//
//  AuthMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 24/10/23.
//

import Foundation

class AuthService {
    
    func logout() -> Bool {
        return true
    }
    func currentUserExist() -> Bool {
        return false
    }
    func signIn(verificationCode: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
       onSuccess()
    }
}
