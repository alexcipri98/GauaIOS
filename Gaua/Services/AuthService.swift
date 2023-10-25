//
//  AuthService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/10/23.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func logout() -> Bool {
        do {
            #warning("Esto hay que cambiarlo, aqui solo tendría que estar la petición")
            try Auth.auth().signOut()
            NavigationService.shared.router.isAuthenticated = false
            NavigationService.shared.router.currentDestination = .login
            return true
        } catch {
            print("Error al cerrar sesión: \(error)")
            return false
        }
    }
    
    func currentUserExist() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
    
    func signIn(verificationCode: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                onFailure(error)
            } else {
                print("Autenticación exitosa en AuthService" + (authResult?.user.phoneNumber ?? ""))
                onSuccess()
            }
        }
    }
}
