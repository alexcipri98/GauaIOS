//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import SwiftUI

final class RegisterViewModel: ObservableObject {
    
    //RegisterStep1 phoneRequest
    @Published var prefix: String = ""
    @Published var phoneNumber: String = ""
    @Published var goVerification: Bool = false

    //RegisterStep2 Verification
    @Published var verificationCode: String = ""
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
    
    private var registerService: RegisterServiceProtocol = RegisterService()
    private var authService: AuthServiceProtocol = AuthService()
    private var phoneNumberValidator = PhoneNumberValidator()
    private var clasifier = ClasifierOfClassOfPerson()
    
    func registerStepOne(){
        NavigationServiceViewModel.shared.showLoading()
        if prefix == "" { prefix = "+34" }
        if phoneNumberValidator.isValidPhoneNumber(prefix: prefix,
                                                   phoneNumber: phoneNumber) {
            authService.getVerificationID(prefix: prefix,
                                              phoneNumber: phoneNumber,
                                              onSuccess: { verificationID in
                DispatchQueue.main.async {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    self.goVerification = true
                    print("Guardado verificationID en UserDefaults")
                }
                NavigationServiceViewModel.shared.hideLoading()
            }, onFailure: { error in
                NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
            })
        } else {
            NavigationServiceViewModel.shared.showError(text: "register_view_phoneError".localized)
        }
    }
    
    func registerStepTwo() {
        authService.signIn(verificationCode: self.verificationCode,
                           onSuccess: {
            print("Usuario autenticado con éxito!")
            self.evaluateIfUserExist(userId: (self.prefix + self.phoneNumber))
        },
                           onFailure: { error in
            NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
        })
        
    }
    
    private func evaluateIfUserExist(userId: String) {
        registerService.existUser(userId: userId,
                                  onSuccessExist: {
            self.login(userId: userId)
        },
                                  onSuccessNotExist: {
            DispatchQueue.main.async {
                self.goName = true
            }
        },
                                  onFailure: { error in
            NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
        })
    }
    
    private func login(userId: String) {
        
        registerService.getUser(userId: userId,
                                onSuccess: { person in
            NavigationServiceViewModel.shared.userSession = person
            NavigationServiceViewModel.shared.router.currentDestination = .main
        },
                                onFailure: { error in
            NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
        })
    }
    
    func loadImageAndRegister() {
        NavigationServiceViewModel.shared.showLoading()
        guard let selectedImage = recortedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        else {
            NavigationServiceViewModel.shared.showError(text: "register_view_imageError".localized)
            return
        }
        
        registerService.loadImage(userId: (self.prefix + self.phoneNumber),
                                  imageData: imageData,
                                  onSuccess: { imageUrl in
                                    self.registerUser(imageUrl: imageUrl)
                                },
                                  onFailure: { error in
                                    NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
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
            
            NavigationServiceViewModel.shared.userSession = currentperson
            NavigationServiceViewModel.shared.navigateTo(destination: .main)
            NavigationServiceViewModel.shared.hideLoading()
        }, onFailure: { error in
            NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
        })
    }
}
