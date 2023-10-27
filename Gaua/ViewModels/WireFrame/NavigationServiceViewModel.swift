//
//  NavigationService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/10/23.
//

import Foundation

final class NavigationServiceViewModel: ObservableObject {
    
    static let shared = NavigationServiceViewModel()
    
    let router = RouterViewModel()
    var userSession : Person?

    func navigateTo(destination: RouterViewModel.Destination) {
        DispatchQueue.main.async {
            self.router.currentDestination = destination
        }
    }
    
    func showError(text: String? = nil) {
        let message = text ?? "any_view_unknown_error".localized
        print("\u{274C} " + message)
        DispatchQueue.main.async {
            self.router.alertMessage = message
            self.router.showAlert = true
            self.router.isLoading = false
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.router.isLoading = true
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.router.isLoading = false
        }
    }
}


final class RouterViewModel: ObservableObject {
    enum Destination {
           case login
           case main
    }
    private var authService = AuthService()

    @Published var isAuthenticated: Bool = false
    @Published var currentDestination: Destination = .login
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    fileprivate init() {
        self.isAuthenticated = authService.currentUserExist()
    }
    
    func logoutUser() {
        if authService.logout() {
            self.isAuthenticated = false
            self.currentDestination = .login
        } else {
            alertMessage = "Hubo un problema al cerrar la sesión. Por favor, inténtalo de nuevo."
            showAlert = true
        }
    }

}

