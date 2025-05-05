//
//  OnboardingView.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 03/05/2025.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    let systemImageName: String
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 20){
            Image(systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(title)
                .font(.title).bold()
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    OnboardingView(systemImageName: "moneyOne", title: "Track Currencies", description: "Stay updated with live exchange rates.")
}
