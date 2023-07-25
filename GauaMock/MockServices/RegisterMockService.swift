//
//  RegisterMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation

class RegisterService {
    
    public func register(person: Person, password: String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
    
}
