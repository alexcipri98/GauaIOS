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
            try Auth.auth().signOut()
            return true
        } catch {
            print("Error al cerrar sesión: \(error)")
            return false
        }
    }
    
    func currentUserExist() -> Bool {
        return (Auth.auth().currentUser == nil)
    }
}
