//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import FirebaseAuth
import libPhoneNumber
import SwiftUI

class RegisterViewModel: ObservableObject {
    
    //RegisterStep1 phoneRequest
    @Published var prefix: String = ""
    @Published var phoneNumber: String = ""
    @Published var showFirstStepError: Bool = false
    @Published var firstStepError: String?
    @Published var goVerification: Bool = false

    //RegisterStep2 Verification
    @Published var verificationCode: String = ""
    @Published var showSecondStepError: Bool = false
    @Published var secondStepError: String?
    @Published var goName: Bool = false

    //RegisterStep3 Name
    @Published var name: String = ""
    @Published var goBirthDate: Bool = false

    //RegisterStep4 BirthDate
    @Published var birthDate: String = ""
    @Published var goGender: Bool = false

    //RegisterStep5 Gender
    @Published var gender: String = ""
    @Published var goWantedGender: Bool = false

    //RegisterStep6 GenderToShow
    @Published var genderToShow: String = ""
    @Published var goImageRequest: Bool = false

    //RegisterStep7 Image
    @Published var selectedImage: UIImage? = nil
    @Published var recortedImage: UIImage? = nil
    @Published var showLastStepError: Bool = false
    @Published var lastStepError: String?
   
    @Published var isLoading = false

    private var registerService = RegisterService()

    func registerStepOne(){
        isLoading = true
        if prefix == "" {
            prefix = "+34"
        }
        if isValidPhoneNumber() {
            registerService.getVerificationID(prefix: prefix,
                                              phoneNumber: phoneNumber,
                                              onSuccess: { verificationID in
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.isLoading = false
                self.goVerification = true
                print("Guardado verificationID en UserDefaults")
            }, onFailure: { error in
                self.firstStepError = error?.localizedDescription
                self.showFirstStepError = true
                self.isLoading = false
            })
        } else {
            self.firstStepError = "El prefijo o el número de teléfono no tienen un formato correcto. \n Ejemplo: +34 666666666"
            self.showFirstStepError = true
            self.isLoading = false
        }
    }
    
    func registerStepTwo() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                self.secondStepError = error.localizedDescription
                self.showSecondStepError = true
                print(error.localizedDescription)
                return
            }
            
            print("Usuario autenticado con éxito!")
            self.goName = true
        }
    }
    func loadImageAndRegister() {
        isLoading = true
        guard let selectedImage = recortedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        else {
            self.lastStepError = "register_view_imageError".localized
            self.showLastStepError = true
            self.isLoading = false
            return
        }
        
        registerService.loadImage(imageData: imageData,
                                  onSuccess: { imageUrl in
                                    self.registerUser(imageUrl: imageUrl)
                                },
                                  onFailure: { error in
                                    self.lastStepError = error?.localizedDescription
                                    self.showLastStepError = true
                                    self.isLoading = false
                                })
        
    }
    
    private func registerUser(imageUrl: String) {
        let currentperson = Person(prefix: self.prefix,
                                   phoneNumber: self.phoneNumber,
                                   name: self.name,
                                   gender: self.gender,
                                   genderToShow: self.genderToShow,
                                   classOfPerson: self.calculateClassOfPerson(),
                                   birthDate: self.birthDate,
                                   imageUrl: imageUrl)
        
        self.registerService.register(person: currentperson,
                                 onSuccess:  {
            
            UserSession.shared.currentUser = currentperson
            self.isLoading = false
            NavigationService.shared.navigateTo(destination: .main)
        }, onFailure: { error in
            self.lastStepError = error?.localizedDescription
            self.showLastStepError = true
            self.isLoading = false
        })
    }
    
    private func isValidPhoneNumber() -> Bool {
        
        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else {
            print("Error al recuperar la instancia NBPhoneNumberUtil")
            return false
        }
        
        do {
            let phoneNumberParsed = try phoneUtil.parse("\(prefix)\(phoneNumber)", defaultRegion: nil)
            return phoneUtil.isValidNumber(phoneNumberParsed)
        } catch {
            self.firstStepError = "any_view_unknown_error".localized
            self.showFirstStepError = true
            print("Error al parsear el número: \(error)")
            return false
        }
    }
   
   /* private func validateRegisterFields() -> Bool {
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
    }*/
    
    private func calculateClassOfPerson() -> ClassOfPerson {
        switch gender {
        case "male_gender_parameter".localized:
            switch genderToShow {
            case "female_gender_parameter".localized:
                return .classA
            case "male_gender_parameter".localized:
                return .classC
            default:
                return .classE
            }
        case "female_gender_parameter".localized:
            switch genderToShow {
            case "male_gender_parameter".localized:
                return .classB
            case "female_gender_parameter".localized:
                return .classD
            default:
                return .classF
            }
        default:
            switch genderToShow {
            case "male_gender_parameter".localized:
                return .classH
            case "female_gender_parameter".localized:
                return .classG
            default:
                return .classI
            }
        }
    }
}
/*
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
*/
