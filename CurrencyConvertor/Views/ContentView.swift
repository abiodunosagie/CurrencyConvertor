//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel = ContentViewModel()
    @State private var amount = ""
    @State private var conversion = ""
    @FocusState private var baseAmountIsFocused: Bool
    @FocusState private var convertedAmountIsFocused: Bool
    // MARK: - COMPUTED PROPS
    
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
//                HStack {
//                    Spacer()
//                    Text(viewModel.errorMessage)
//                        .font(.headline)
//                        .foregroundStyle(.red)
//                    Spacer()
//                }
            
                Text("Amount")
                    .font(.system(size: 15, weight: .semibold))
                TextField(
                    "",
                    value: $viewModel.baseAmount,
                    formatter: viewModel.numberFormatter)
                .focused($baseAmountIsFocused)
                .onSubmit {
                    viewModel.convert()
                    baseAmountIsFocused = false
                    convertedAmountIsFocused = false
                }
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .overlay(alignment: .trailing) {
                    HStack{
                        viewModel.baseCurrency.image()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Menu {
                            ForEach(CurrencyChoice.allCases) { currencyChoice in
                                Button {
                                    viewModel.baseCurrency = currencyChoice
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
                TextField(
                    "",
                    value: $viewModel.convertedAmount,
                    formatter: viewModel
                        .numberFormatter)
                .focused($convertedAmountIsFocused)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .overlay(alignment: .trailing) {
                    HStack{
                        viewModel.convertedCurrency.image()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Menu {
                            ForEach(CurrencyChoice.allCases) { currencyChoice in
                                Button {
                                    viewModel.convertedCurrency = currencyChoice
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
                    Text("1.000000 USD == 2.000000 EUR")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top)
                    Spacer()
                }
            }
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
        }//: ZSTACK
        .onTapGesture {
            viewModel.convert()
            baseAmountIsFocused = false
            convertedAmountIsFocused = false
        }
    }
}

#Preview {
    ContentView()
}
