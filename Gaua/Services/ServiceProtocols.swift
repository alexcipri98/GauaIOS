//
//  ServiceProtocols.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/10/23.
//

import Foundation

protocol RegisterServiceProtocol {
    func existUser(userId: String, onSuccessExist: @escaping() -> Void, onSuccessNotExist: @escaping() -> Void, onFailure: @escaping (Error?) -> Void)
    func register(person: Person, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void)
    func loadImage(userId: String, imageData: Data, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void)
    func getUser(userId: String, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void)
}

protocol AuthServiceProtocol {
    func logout() -> Bool
    func currentUserExist() -> UserAuthType?
    func signInCode(verificationCode: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void)
    func signInEmail(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void)
    func getVerificationID(prefix: String, phoneNumber: String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void)
}

protocol PubsSignInServiceProtocol {
    func getUser(email: String, onSuccess: @escaping (PubsPerson) -> Void, onFailure: @escaping (Error?) -> Void) 
}
