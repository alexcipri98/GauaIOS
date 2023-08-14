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
    @Published var genderToShow: String = "Bisexual"
    @Published var yearOfBorn: Int = 2023
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var showVerify: Bool = false
    private var registerService = RegisterService()
    private var classOfPerson: ClassOfPerson?
    
    func register() {
        calculateClassOfPerson()
        let currentperson = Person(email: email,
                               name: name,
                               gender: gender,
                               genderToShow: genderToShow,
                               classOfPerson: classOfPerson ?? .classI,
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
    
    private func calculateClassOfPerson() {
        switch gender {
        case "male_gender_parameter".localized:
            switch genderToShow {
            case "female_gender_parameter".localized:
                classOfPerson = .classA
            case "male_gender_parameter".localized:
                classOfPerson = .classC
            default:
                classOfPerson = .classE
            }
        case "female_gender_parameter".localized:
            switch genderToShow {
            case "male_gender_parameter".localized:
                classOfPerson = .classB
            case "female_gender_parameter".localized:
                classOfPerson = .classD
            default:
                classOfPerson = .classF
            }
        default:
            switch genderToShow {
            case "male_gender_parameter".localized:
                classOfPerson = .classH
            case "female_gender_parameter".localized:
                classOfPerson = .classG
            default:
                classOfPerson = .classI
            }
        }
    }
}
