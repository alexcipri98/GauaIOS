//
//  RegisterMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation

class RegisterService: RegisterServiceProtocol {
    
    public func existUser(userId: String, onSuccessExist: @escaping() -> Void, onSuccessNotExist: @escaping() -> Void, onFailure: @escaping (Error?) -> Void) {
        if userId == "+34666666666" {
            onSuccessExist()
        }
        else if userId == "error" {
            let error = NSError(domain: "GauaMock",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Error en existUserMock"])
            onFailure(error)
        } else {
            onSuccessNotExist()
        }
    }
    
    public func register(person: Person, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
        if person.imageUrl == "123456" {
            onSuccess()
        } else {
            let error = NSError(domain: "GauaMock",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Error en registerMock"])
            onFailure(error)
        }
    }
    public func loadImage(userId: String, imageData: Data, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void) {
        if userId == "existing" {
            onSuccess("123456")
        } else {
            let error = NSError(domain: "GauaMock",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Error en loadImageMock"])
            onFailure(error)
        }
    }
    
    public func getUser(userId: String, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void) {
        let p = Person(prefix: "+34",
                phoneNumber: "666666666",
                name: "Alex",
                gender: "Male",
                genderToShow: "Female",
                classOfPerson: .classA,
                birthDate: "16/09/1998",
                imageUrl: "url")
        onSuccess(p)
    
    }
    
    private func retrieveImageOfUser(person: Person, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void) {
        let p = Person(prefix: "+34",
                phoneNumber: "666666666",
                name: "Alex",
                gender: "Male",
                genderToShow: "Female",
                classOfPerson: .classA,
                birthDate: "16/09/1998",
                imageUrl: "url")
        onSuccess(p)
    }
    
}
