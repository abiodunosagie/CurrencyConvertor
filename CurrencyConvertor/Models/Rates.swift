//
//  Rates.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 28/04/2025.
//

import Foundation

struct Rates: Decodable, Encodable {
    let rates: [String: Double]
}
