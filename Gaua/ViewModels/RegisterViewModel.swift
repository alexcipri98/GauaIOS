//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
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
    
    private var registerService: RegisterServiceProtocol = RegisterService()
    private var authService: AuthServiceProtocol = AuthService()
    private var phoneNumberValidator = PhoneNumberValidator()
    private var clasifier = ClasifierOfClassOfPerson()
    
    func registerStepOne(){
        isLoading = true
        if prefix == "" {
            prefix = "+34"
        }
        if phoneNumberValidator.isValidPhoneNumber(prefix: prefix,
                                                   phoneNumber: phoneNumber) {
            authService.getVerificationID(prefix: prefix,
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
            self.firstStepError = "register_view_phoneError".localized
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
        let personClass = clasifier.calculateClassOfPerson(gender: self.gender,
                                                                          genderToShow: self.genderToShow)
        let currentperson = Person(prefix: self.prefix,
                                   phoneNumber: self.phoneNumber,
                                   name: self.name,
                                   gender: self.gender,
                                   genderToShow: self.genderToShow,
                                   classOfPerson: personClass,
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
}
