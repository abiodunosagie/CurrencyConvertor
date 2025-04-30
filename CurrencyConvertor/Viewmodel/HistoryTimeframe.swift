//
//  HistoryTimeframe.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 30/04/2025.
//

import Foundation

// Move this to the top of the file or a new file
enum HistoryTimeframe: String, CaseIterable, Identifiable {
    case week = "1 Week"
    case month = "1 Month"
    case threeMonths = "3 Months"
    case year = "1 Year"

    var id: Self { self }

    var days: Int {
        switch self {
        case .week: return 7
        case .month: return 30
        case .threeMonths: return 90
        case .year: return 365
        }
    }
}
