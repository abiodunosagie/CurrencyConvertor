//
//  ContentView.swift
//  CurrencyConvertor
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel = ContentViewModel()
    @State private var amount = ""
    @FocusState private var baseAmountIsFocused: Bool
    @FocusState private var convertedAmountIsFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment:.leading) {
                        Text("Amount")
                            .font(.system(size: 15, weight: .semibold))
                        
                        TextField(
                            "",
                            value: $viewModel.baseAmount,
                            formatter: viewModel.numberFormatter
                        )
                        .focused($baseAmountIsFocused)
                        .keyboardType(.decimalPad)
                        .onSubmit {
                            viewModel.convert()
                            baseAmountIsFocused = false
                            convertedAmountIsFocused = false
                        }
                        .onChange(of: amount) { oldValue, newValue in
                            if let number = viewModel.numberFormatter.number(from: newValue) {
                                viewModel.baseAmount = number.doubleValue
                                viewModel.convert()
                            }
                        }
                        
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                        .overlay(alignment: .trailing) {
                            HStack {
                                viewModel.baseCurrency.image()
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                Menu {
                                    ForEach(CurrencyChoice.allCases) { currencyChoice in
                                        Button {
                                            viewModel.baseCurrency = currencyChoice
                                            viewModel.convert()
                                        } label: {
                                            Text(currencyChoice.fetchMenuName())
                                        }
                                    }
                                } label: {
                                    Text(viewModel.baseCurrency.rawValue)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundStyle(.black)
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.trailing)
                        }
                        
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.vertical)
                            Spacer()
                        }
                        
                        Text("Converted To")
                            .font(.system(size: 15, weight: .semibold))
                        
                        TextField(
                            "",
                            value: $viewModel.convertedAmount,
                            formatter: viewModel.numberFormatter
                        )
                        .focused($convertedAmountIsFocused)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                        .overlay(alignment: .trailing) {
                            HStack {
                                viewModel.convertedCurrency.image()
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                Menu {
                                    ForEach(CurrencyChoice.allCases) { currencyChoice in
                                        Button {
                                            viewModel.convertedCurrency = currencyChoice
                                            viewModel.convert()
                                        } label: {
                                            Text(currencyChoice.fetchMenuName())
                                        }
                                    }
                                } label: {
                                    Text(viewModel.convertedCurrency.rawValue)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundStyle(.black)
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.trailing)
                        }
                        
                        HStack {
                            Spacer()
                            Text("1000.00 \(viewModel.baseCurrency.rawValue) = \(viewModel.convertedAmount, specifier: "%.2f") \(viewModel.convertedCurrency.rawValue)")
                            
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.top)
                            Spacer()
                            
                        }
                        
                        // MARK: - ERROR MESSAGE
                        if !viewModel.errorMessage.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                    Text(viewModel.errorMessage)
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Button("Try Again") {
                                    Task {
                                        await viewModel.fetchRates()
                                    }
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                            }
                            .padding(.top, 8)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 10)
                    Button {
                        Task {
                            await viewModel.fetchHistoricalRates()
                            viewModel.showingHistoricalChart = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            Text("View Historical Trends")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }
                    .padding(.top, 10)
                    Spacer()
                } //: VSTACK
                .padding(.horizontal)
                .task {
                    await viewModel.fetchRates()
                }
                
                if viewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        ProgressView()
                            .tint(.white)
                    }
                }
            } //: ZSTACK
            .onTapGesture {
                viewModel.convert()
                baseAmountIsFocused = false
                convertedAmountIsFocused = false
                if let number = viewModel.numberFormatter.number(from: amount) {
                    viewModel.baseAmount = number.doubleValue
                    viewModel.convert()
                }
            }
            .sheet(isPresented: $viewModel.showingHistoricalChart) {
                VStack {
                    Picker("Timeframe", selection: $viewModel.historyTimeframe) {
                        ForEach(HistoryTimeframe.allCases) { timeframe in
                            Text(timeframe.rawValue.capitalized)
                                .tag(timeframe)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    CurrencyChartView(
                        historicalData: viewModel.historicalData,
                        baseCurrency: viewModel.baseCurrency,
                        targetCurrency: viewModel.convertedCurrency,
                        timeFrame: viewModel.historyTimeframe,
                        isPresented: $viewModel.showingHistoricalChart
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(.myprofile)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back 👋")
                                .font(.headline)
                            Text("Let’s convert some money today!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button("Sign Out") {
                          
                        }
                        .font(.footnote)
                    }
                   
                }
            }
        }

    }
}

#Preview {
    ContentView()
}

