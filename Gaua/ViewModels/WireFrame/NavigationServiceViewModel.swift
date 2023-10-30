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
    var pubsUserSession: PubsPerson?
    
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
        case register
        case main
        case mainPubs
    }
    private var authService = AuthService()

    @Published var isAuthenticatedUserClient: Bool = false
    @Published var isAuthenticatedPubClient: Bool = false
    @Published var currentDestination: Destination = .register
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    fileprivate init() {
        guard let typeOfAuthenticatedUser = authService.currentUserExist() else { return }
        if typeOfAuthenticatedUser == .userPub {
            isAuthenticatedPubClient = true
        } else if typeOfAuthenticatedUser == .userClient  {
            isAuthenticatedUserClient = true
        }
    }
    
    func logoutUser() {
        if authService.logout() {
            self.isAuthenticatedPubClient = false
            self.isAuthenticatedUserClient = false
            self.currentDestination = .register
        } else {
            alertMessage = "Hubo un problema al cerrar la sesión. Por favor, inténtalo de nuevo."
            showAlert = true
        }
    }

}

