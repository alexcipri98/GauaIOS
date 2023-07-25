//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var gender: String = "Otro"
    @Published var sexualOrientation: String = "Bisexual"
    @Published var yearOfBorn: Int = 2023
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var showVerify: Bool = false
    private var registerService = RegisterService()
    
    func register() {
        
        let currentperson = Person(email: email,
                               name: name,
                               gender: gender,
                               sexualOrientation: sexualOrientation,
                                   yearOfBorn: yearOfBorn,
                                   imageUrl: "")
        
        registerService.register(person: currentperson,
                           password: password,
                           onSuccess:  { boolean in
            self.showVerify = true
        }, onFailure: { error in
                               self.errorText = error?.localizedDescription ?? "Ha ocurrido un error, intentelo más tarde"
                               self.showError = true
                           })
    }
    
}
