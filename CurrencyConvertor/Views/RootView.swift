//
//  RootView.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 06/05/2025.
//

import SwiftUI

struct RootView: View {
    @State private var hasSeenOnboarding = false

    var body: some View {
        if hasSeenOnboarding {
            ContentView()
        } else {
            MainOnboardView()
        }
    }
}


#Preview {
    RootView()
}
