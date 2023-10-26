//
//  RouterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/10/23.
//

import Foundation
import FirebaseAuth

class RouterViewModel: ObservableObject {
    enum Destination {
           case login
           case main
    }
    private var authService = AuthService()

    @Published var isAuthenticated: Bool = false
    @Published var currentDestination: Destination = .login
    
    init() {
        self.isAuthenticated = authService.currentUserExist()
    }

    func navigateTo(destination: Destination) {
        DispatchQueue.main.async {
            self.currentDestination = destination
        }
    }
    
    func logoutUser() {
        if authService.logout() {
            self.isAuthenticated = false
            self.currentDestination = .login
        } else {
            #warning("Esto no debería fallar nunca, ¿Pero que se hace si falla?")
        }
    }
}
