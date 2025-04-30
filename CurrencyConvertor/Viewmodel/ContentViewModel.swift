//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 28/04/2025.
//

import Foundation
import Combine
import SystemConfiguration
@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var convertedAmount = 0.62
    @Published var baseAmount = 1000.0
    @Published var baseCurrency: CurrencyChoice = .Nigerian
    @Published var convertedCurrency: CurrencyChoice = .Usa
    @Published var rates: Rates?
    @Published var isLoading = true
    @Published var errorMessage = "Fake Error"
    @Published var historicalData: [HistoricalDataPoint] = []
    @Published var isLoadingHistorical = false
    @Published var showingHistoricalChart = false
    @Published var historyTimeframe: HistoryTimeframe = .week
    @Published var isOfflineMode = false
    private var lastUpdateTime: Date?
    private let userDefaults = UserDefaults.standard
    
    // Add this initializer
    init() {
        // Load cached rates if available
        loadCachedRates()
    }
    // MARK: - COMPUTED PROPERTIES
    private func loadCachedRates() {
        guard let cachedData = userDefaults.data(forKey: "cachedRates"),
              let cachedRates = try? JSONDecoder().decode(Rates.self, from: cachedData),
              let lastUpdate = userDefaults.object(forKey: "lastRatesUpdate") as? Date else {
            return
        }
        
        self.rates = cachedRates
        self.lastUpdateTime = lastUpdate
        
        // Format as relative time
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeTimeString = formatter.localizedString(for: lastUpdate, relativeTo: Date())
        print("Loaded cached rates from \(relativeTimeString)")
    }
    
    private func cacheCurrentRates() {
        guard let rates = rates else { return }
        
        do {
            let encodedRates = try JSONEncoder().encode(rates)
            userDefaults.set(encodedRates, forKey: "cachedRates")
            
            let now = Date()
            userDefaults.set(now, forKey: "lastRatesUpdate")
            self.lastUpdateTime = now
        } catch {
            print("Failed to cache rates: \(error)")
        }
    }
    
    
    // Add this method to fetch historical data
    func fetchHistoricalRates() async {
        await MainActor.run {
            isLoadingHistorical = true
            historicalData = []
        }
        
        // Calculate dates for the selected timeframe
        let calendar = Calendar.current
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -historyTimeframe.days, to: endDate)!
        
        // Format dates for API
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // We'll use a batch of async calls to get data for several dates
        var dataPoints: [HistoricalDataPoint] = []
        
        // For better charts, let's get data points at regular intervals
        let interval: Int
        switch historyTimeframe {
        case .week: interval = 1 // daily for a week
        case .month: interval = 2 // every other day for a month
        case .threeMonths: interval = 6 // every 6 days for 3 months
        case .year: interval = 15 // every 15 days for a year
        }
        
        var currentDate = startDate
        while currentDate <= endDate {
            let dateString = dateFormatter.string(from: currentDate)
            
            if let dataPoint = await fetchRateForDate(dateString, baseCurrency: baseCurrency.rawValue, targetCurrency: convertedCurrency.rawValue) {
                dataPoints.append(dataPoint)
            }
            
            // Move to next interval
            currentDate = calendar.date(byAdding: .day, value: interval, to: currentDate)!
        }
        
        // Sort by date
        dataPoints.sort { $0.date < $1.date }
        
        await MainActor.run {
            self.historicalData = dataPoints
            self.isLoadingHistorical = false
        }
    }
    
    private func fetchRateForDate(_ dateString: String, baseCurrency: String, targetCurrency: String) async -> HistoricalDataPoint? {
        // OpenExchangeRates historical endpoint (this requires a paid plan, so you might need to switch providers)
        guard let url = URL(string: "https://openexchangerates.org/api/historical/\(dateString).json?app_id=398871fc6a7e4d7680e932154c6e21c5") else {
            print("Invalid URL for historical data")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(HistoricalRatesResponse.self, from: data)
            
            // Calculate the exchange rate
            if let baseRate = response.rates[baseCurrency], let targetRate = response.rates[targetCurrency] {
                let rate = targetRate / baseRate
                
                // Create date from string
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let date = dateFormatter.date(from: dateString) {
                    return HistoricalDataPoint(date: date, rate: rate)
                }
            }
        } catch {
            print("Error fetching historical data: \(error)")
        }
        
        return nil
    }
    
    
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
        // Check network connection first
        if !isConnectedToNetwork() {
            await MainActor.run {
                isOfflineMode = true
                if rates == nil {
                    errorMessage = "You're offline. No cached rates available."
                } else {
                    errorMessage = "You're offline. Showing last cached rates."
                }
                isLoading = false
            }
            return
        }
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
    
    // Helper function to check network connectivity
    func isConnectedToNetwork() -> Bool {
        // This is a simplified implementation
        // For a real app, use NWPathMonitor from Network framework
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
    
    func convert() {
        if let rates = rates,  let baseExchangeRate = rates.rates[baseCurrency.rawValue], let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
            convertedAmount = (
                convertedExchangeRate / baseExchangeRate
            ) * baseAmount
            
        }
    }
}
