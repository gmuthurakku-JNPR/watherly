//
//  LoginView.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 15/03/25.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var authViewModel = LoginViewModel()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                if authViewModel.isLoggedIn {
                    VStack {
                        Text("Welcome, \(authViewModel.userEmail)!")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        
                        Button(action: {
                            authViewModel.logout()
                        }) {
                            Text("Log Out")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 40)
                    }
                } else {
                    VStack(spacing: 16) {
                        Text("Weatherly")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        VStack(spacing: 12) {
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 40)
                        
                        Button(action: {
                            authViewModel.login(email: email, password: password)
                        }) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 40)
                        
                        Button(action: {
                            authViewModel.signUp(email: email, password: password)
                        }) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 40)
                        
                        GoogleSignInButton(action: {
                            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let rootViewController = scene.windows.first?.rootViewController {
                                authViewModel.signInWithGoogle(presenting: rootViewController)
                            }
                        })
                        .cornerRadius(10)
                        .padding(.horizontal, 40)


                        if !authViewModel.errorMessage.isEmpty {
                            Text(authViewModel.errorMessage)
                                .foregroundColor(.red)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                }
            }
            .animation(.easeInOut, value: authViewModel.isLoggedIn)
        }
    }
}
