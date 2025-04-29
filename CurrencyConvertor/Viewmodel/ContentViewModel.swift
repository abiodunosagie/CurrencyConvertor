//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 28/04/2025.
//

import Foundation

@MainActor
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
    
    
    var conversionRate: Double {
        if let rates = rates,
           let baseExchangeRate = rates.rates[baseCurrency.rawValue],
           let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
            return convertedExchangeRate / baseExchangeRate
        }
        return 1
    }
    
    func fetchRates() async {
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=398871fc6a7e4d7680e932154c6e21c5") else {
            await MainActor.run {
                errorMessage = "Oops! Something went wrong while preparing the request."
            }
            print("💥 Developer Error: Invalid API URL.")
            return
        }
        
        await MainActor.run {
            isLoading = true
            errorMessage = "" // Clear old error if any
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                await MainActor.run {
                    errorMessage = "Unexpected response from server."
                }
                print("⚠️ Developer Warning: Could not cast response to HTTPURLResponse.")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                await MainActor.run {
                    errorMessage = "Server returned an error. Please try again later."
                }
                print("🛑 Developer Error: HTTP Status Code \(httpResponse.statusCode)")
                return
            }

            let decodedRates = try JSONDecoder().decode(Rates.self, from: data)
            
            await MainActor.run {
                self.rates = decodedRates
                self.isLoading = false
            }
            
        } catch let decodingError as DecodingError {
            await MainActor.run {
                errorMessage = "We're having trouble processing the data. Try again shortly."
                isLoading = false
            }
            print("❌ Developer Error: Decoding failed - \(decodingError.localizedDescription)")
            
        } catch {
            await MainActor.run {
                errorMessage = "Please check your internet connection and try again."
                isLoading = false
            }
            print("🌐 Network Error: \(error.localizedDescription)")
        }
    }


    
    func convert() {
        if let rates = rates,  let baseExchangeRate = rates.rates[baseCurrency.rawValue], let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
            convertedAmount = (
                convertedExchangeRate / baseExchangeRate
            ) * baseAmount
           
        }
    }
}
