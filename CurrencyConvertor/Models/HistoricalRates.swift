//
//  HistoricalRatesResponse.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 30/04/2025.
//

import Foundation

struct HistoricalRatesResponse: Decodable {
    let rates: [String: Double]
    let timestamp: TimeInterval
    let base: String
}

struct HistoricalDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let rate: Double
}
