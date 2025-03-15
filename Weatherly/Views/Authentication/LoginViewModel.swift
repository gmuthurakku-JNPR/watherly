//
//  AuthViewModel.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 15/03/25.
//


import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoggedIn: Bool = false

    init() {
        checkUserStatus()
    }

    func checkUserStatus() {
        if let currentUser = FirebaseAuthService.shared.getCurrentUser() {
            userEmail = currentUser.email ?? "No Email"
            isLoggedIn = true
        } else {
            userEmail = ""
            isLoggedIn = false
        }
    }

    func signUp(email: String, password: String) {
        FirebaseAuthService.shared.signUp(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.userEmail = user.email ?? "No Email"
                    self.isLoggedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func login(email: String, password: String) {
        FirebaseAuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.userEmail = user.email ?? "No Email"
                    self.isLoggedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func logout() {
        FirebaseAuthService.shared.logout { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.userEmail = ""
                    self.isLoggedIn = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signInWithGoogle(presenting viewController: UIViewController) {
        FirebaseAuthService.shared.signInWithGoogle(presenting: viewController) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.userEmail = user.email ?? "No Email"
                    self.isLoggedIn = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
