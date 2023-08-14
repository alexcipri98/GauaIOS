//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var showEmailError: Bool = false
    @Published var password: String = ""
    @Published var showPasswordError: Bool = false
    @Published var name: String = ""
    @Published var showNameError: Bool = false
    @Published var gender: String = "other_gender_parameter".localized
    @Published var genderToShow: String = "bisexual_orientation_parameter".localized
    @Published var yearOfBorn: Int = 2023
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var showVerify: Bool = false
    private var registerService = RegisterService()
    private var classOfPerson: ClassOfPerson?
    
    func register() {
        if validateRegisterFields() {
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
    }
    
    private func validateRegisterFields() -> Bool {
        if !isValidEmail(email) {
            showEmailError = true
            return false
        }
        if !isValidPassword(password) {
            showEmailError = false
            showPasswordError = true
            return false
        }
        if name == "" {
            showPasswordError = false
            showEmailError = false
            showNameError = true
            return false
        }
        return true
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

extension RegisterViewModel {
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        guard 8...16 ~= password.count else { return false }

        let capitalLetterPattern = ".*[A-Z]+.*"
        
        let numberPattern = ".*[0-9]+.*"

        let specialCharacterPattern = ".*[^a-zA-Z0-9\\s]+.*"

        let capitalLetterRegex = try? NSRegularExpression(pattern: capitalLetterPattern)
        let numberRegex = try? NSRegularExpression(pattern: numberPattern)
        let specialCharacterRegex = try? NSRegularExpression(pattern: specialCharacterPattern)

        if let _ = capitalLetterRegex?.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.count)),
           let _ = numberRegex?.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.count)),
           let _ = specialCharacterRegex?.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.count)) {
            return true
        }
        return false
    }
}
