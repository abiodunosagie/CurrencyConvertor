//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 28/04/2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var convertedAmount = 1.0
    @Published var baseAmount = 1.0
    @Published var baseCurrency: CurrencyChoice = .Nigerian
    @Published var convertedCurrency: CurrencyChoice = .Usa
    @Published var rates: Rates?
    @Published var isLoading = true
    @Published var errorMessage = "Fake Error"
    
    // MARK: - COMPUTED PROPERTIES
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
    func fetchRates() async {
        guard   let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=398871fc6a7e4d7680e932154c6e21c5") else {
            errorMessage = "Could not fetch rates."
            print("API url is not valid")
            return
        }
        let urlRequest = URLRequest(url: url)
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            rates = try JSONDecoder().decode(Rates.self, from: data)
        } catch {
            errorMessage = "Could not fetch rates."
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func convert() {
        if let rates = rates,  let baseExchangeRate = rates.rates[baseCurrency.rawValue], let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
            convertedAmount = (
                convertedExchangeRate / baseExchangeRate
            ) * baseAmount
           
        }
    }
}
