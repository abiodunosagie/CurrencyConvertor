//
//  Signin.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 06/05/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Signin: View {
    // MARK: - PROPERTIES
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var navigateToSignUp = false
    @State private var userIsLoggedIn = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    // MARK: - Functions
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
                wrongPassword = 2
                wrongUsername = 2
            } else {
                // Success - Auth state listener will handle navigation
                print("Login successful")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundStyle(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundStyle(.white)
                VStack(spacing: 10) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .border(.red, width: CGFloat(wrongUsername))
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .border(.red, width: CGFloat(wrongPassword))
                        
                    if showError {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .frame(width: 300, alignment: .leading)
                    }
                    
                    Button {
                        login()
                    } label: {
                        Text("Login")
                            .foregroundStyle(.white)
                            .frame(width: 300, height: 50)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.top, 10)
                    
                    Button {
                        navigateToSignUp = true
                    } label: {
                        Text("Don't have an account? SignUp")
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .padding(.top, 5)
                } //: VSTACK
            } //: ZSTACK
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUp()
            }
            .navigationDestination(isPresented: $userIsLoggedIn) {
                HomeView() // Navigate to your main app view when logged in
            }
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn = true
                    }
                }
            }
            .alert("Login Error", isPresented: $showError) {
                Button("OK") {
                    showError = false
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    Signin()
}
