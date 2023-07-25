//
//  LoginMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation

class LoginService {
    public func login(email: String, password: String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
}
