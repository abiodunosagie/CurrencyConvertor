//
//  CurrencyConvertorApp.swift
//  CurrencyConvertor
//
//

import SwiftUI
import Firebase

@main
struct CurrencyConvertorApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
