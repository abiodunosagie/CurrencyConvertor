//
//  CurrencyChartView.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 30/04/2025.
//

import SwiftUI
import Charts

struct CurrencyChartView: View {
    // MARK: - PROPERTIES
    let historicalData: [HistoricalDataPoint]
    let baseCurrency: CurrencyChoice
    let targetCurrency: CurrencyChoice
    let timeFrame: HistoryTimeframe
    @Binding var isPresented: Bool
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                if historicalData.isEmpty {
                    Text("No historical data available")
                        .font(.headline)
                        .padding()
                } else {
                    VStack(alignment: .leading) {
                        Text("\(baseCurrency.rawValue) to \(targetCurrency.rawValue) - \(timeFrame.rawValue)")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(historicalData) { dataPoint in
                                LineMark(
                                    x: .value("Date", dataPoint.date),
                                    y: .value("Rate", dataPoint.rate)
                                )
                                .foregroundStyle(Color.blue)
                                .interpolationMethod(.catmullRom)
                            }
                        }
                        .chartXAxis {
                            AxisMarks(values: .automatic) { value in
                                AxisGridLine()
                                AxisValueLabel {
                                    if let date = value.as(Date.self) {
                                        Text(date, format: .dateTime.month().day())
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .frame(height: 300)
                        .padding()
                        
                        // Stats about the rate
                        if let minRate = historicalData.min(by: { $0.rate < $1.rate })?.rate,
                           let maxRate = historicalData.max(by: { $0.rate < $1.rate })?.rate,
                           let currentRate = historicalData.last?.rate,
                           let oldestRate = historicalData.first?.rate {
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Current:").bold()
                                    Text(String(format: "%.4f", currentRate))
                                    
                                    Spacer()
                                    
                                    let percentChange = ((currentRate - oldestRate) / oldestRate) * 100
                                    Text(percentChange >= 0 ? "↑" : "↓")
                                        .foregroundColor(percentChange >= 0 ? .green : .red)
                                    Text(String(format: "%.2f%%", abs(percentChange)))
                                        .foregroundColor(percentChange >= 0 ? .green : .red)
                                }
                                
                                HStack {
                                    Text("Low:").bold()
                                    Text(String(format: "%.4f", minRate))
                                    
                                    Spacer()
                                    
                                    Text("High:").bold()
                                    Text(String(format: "%.4f", maxRate))
                                }
                            }
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Historical Chart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}



// MARK: - PREVIEW
#Preview {
    CurrencyChartView(
        historicalData: [
            HistoricalDataPoint(date: Date().addingTimeInterval(-86400 * 3), rate: 750),
            HistoricalDataPoint(date: Date().addingTimeInterval(-86400 * 2), rate: 760),
            HistoricalDataPoint(date: Date().addingTimeInterval(-86400 * 1), rate: 770),
            HistoricalDataPoint(date: Date(), rate: 780),
        ],
        baseCurrency: .Nigerian,
        targetCurrency: .Usa,
        timeFrame: .week,
        isPresented: .constant(true)
    )
}

