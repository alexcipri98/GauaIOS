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
    private var authService = AuthService()
    
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
        authService.signIn(verificationCode: self.verificationCode,
                           onSuccess: {
            print("Usuario autenticado con éxito!")
            self.evaluateIfUserExist(userId: (self.prefix + self.phoneNumber))
        },
                           onFailure: { error in
            self.secondStepError = error?.localizedDescription
                self.showSecondStepError = true
            print(error?.localizedDescription ?? "Error en el registerStepTwo del RegisterViewModel")
        })
        
    }
    
    private func evaluateIfUserExist(userId: String) {
        registerService.existUser(userId: userId,
                                  onSuccessExist: {
            self.login(userId: userId)
        },
                                  onSuccessNotExist: {
            self.goName = true
        },
                                  onFailure: { error in
            self.secondStepError = error?.localizedDescription ?? "any_view_unknown_error".localized
            self.showSecondStepError = true
            print(error?.localizedDescription ?? "Error en registerStepTwo")
        })
    }
    
    private func login(userId: String) {
        
        registerService.getUser(userId: userId,
                                onSuccess: { person in
            UserSession.shared.currentUser = person
            NavigationService.shared.router.currentDestination = .main
        },
                                onFailure: { error in
            self.secondStepError = error?.localizedDescription ?? "any_view_unknown_error".localized
            self.showSecondStepError = true
            print(error?.localizedDescription ?? "Error en el login")
        })
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
        
        registerService.loadImage(userId: (self.prefix + self.phoneNumber),
                                  imageData: imageData,
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
