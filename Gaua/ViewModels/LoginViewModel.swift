//
//  LoginViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var isLoggingIn = false
    private var loginService = LoginService()
    
    func login() {
        isLoggingIn = true
        loginService.login(email: email,
                           password: password,
                           onSuccess:  { currentUser in
                                if let logedUser = currentUser {
                                    UserSession.shared.currentUser = logedUser
                                    self.isLoggingIn = false
                                    NavigationService.shared.navigateTo(destination: .main)
                                } else {
                                    print("Error: No se ha encontrado el usuario especificado")
                                    self.isLoggingIn = false
                                    self.errorText = "No se ha encontrado el usuario especificado"
                                    self.showError = true
                                }
                           }, onFailure: { error in
                                print("Login error: \(error?.localizedDescription ?? "")")
                               self.errorText = error?.localizedDescription ?? "Error desconocido, intentelo en unos instantes"
                               self.showError = true
                               self.isLoggingIn = false
                           },
                            onNoVerified: {
                                self.errorText = "Usuario no verificado, revise su correo electrónico."
                                self.showError = true
                                self.isLoggingIn = false
                            })
    }
    
}
