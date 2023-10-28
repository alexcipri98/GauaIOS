//
//  AuthMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 24/10/23.
//

import Foundation

class AuthService: AuthServiceProtocol {
    
    func logout() -> Bool {
        return true
    }
    func currentUserExist() -> Bool {
        return false
    }
    func signIn(verificationCode: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
       onSuccess()
    }
    func getVerificationID(prefix: String, phoneNumber: String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void) {
        if prefix == "+34" && phoneNumber == "666666666" {
            onSuccess("123456")
        } else {
            let error = NSError(domain: "GauaMock",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Error en getVerificationIDMock"])
            onFailure(error)
        }
    }
}
