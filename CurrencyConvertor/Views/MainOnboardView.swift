//
//  MainOnboardView.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 05/05/2025.
//

import SwiftUI

struct MainOnboardView: View {
    
    // MARK: - PROPERTIES
    @State private var currentPage = 0
    @State private var navigateToHome = false
  //  @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @Binding var hasSeenOnboarding: Bool
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $currentPage) {
                    OnboardingView(
                        systemImageName: "moneyOne",
                        title: "Track Currencies",
                        description: "Stay updated with live exchange rates."
                    )
                    .tag(0)
                    
                    OnboardingView(
                        systemImageName: "moneytwo",
                        title: "Multi-Currency Support",
                        description: "Convert between USD, EUR, NGN, and more."
                    )
                    .tag(1)
                    
                    OnboardingView(
                        systemImageName: "moneythree",
                        title: "Quick & Easy",
                        description: "Fast conversions at your fingertips."
                    )
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .animation(.easeInOut, value: currentPage)
                .frame(maxHeight: .infinity)
                
                // Continue Button
                if currentPage == 2 {
                    Button(action: {
                        hasSeenOnboarding = true
                        navigateToHome = true
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 40)
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: currentPage)
                }

                NavigationLink(
                    destination: ContentView(
                        hasSeenOnboarding: .constant(true)
                    ),
                    isActive: $navigateToHome
                ) {
                    EmptyView()
                }
            }
        }
    }
}


#Preview {
    MainOnboardView(hasSeenOnboarding: .constant(false))
}
