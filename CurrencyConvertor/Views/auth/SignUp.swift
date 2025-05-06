//
//  SignUp.swift
//  CurrencyConvertor
//
//  Created by Abiodun Osagie on 06/05/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUp: View {
    // MARK: - PROPERTIES
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    
    // MARK: - Functions
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("SignUp")
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
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .border(.red, width: CGFloat(wrongPassword))
                
                Button {
                    register()
                } label: {
                    Text("Register")
                        .foregroundStyle(.white)
                        .frame(width: 300, height: 50)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                NavigationLink(
                    destination: Text("You are logged in \(email)"),
                    isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                Button {
                  
                } label: {
                        Text("Already have an account? Login")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(.black.opacity(0.7))
                           
                }
                
            }
            .navigationBarHidden(true)
        }//: VSTACK
    }
}

#Preview {
    SignUp()
}
