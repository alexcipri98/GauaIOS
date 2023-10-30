//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 30/10/23.
//

import Foundation
import SwiftUI

final class RegisterViewModel: ObservableObject {
    // RegisterStep1 phoneNumberRequest
    @Published var prefix: String = ""
    @Published var phoneNumber: String = ""
    @Published var goVerification: Bool = false
    
    // RegisterStep2 CodeVerification
    @Published var verificationCode: String = ""
    @Published var goName: Bool = false
    
    // RegisterStep3 Name
    @Published var name: String = ""
    @Published var goBirthDate: Bool = false
    
    // RegisterStep4 BirthDate
    @Published var birthDate: String = ""
    @Published var goGender: Bool = false
    
    // RegisterStep5 Gender
    @Published var gender: String = ""
    @Published var goWantedGender: Bool = false
    
    // RegisterStep6 GenderToShow
    @Published var genderToShow: String = ""
    @Published var goImageRequest: Bool = false

    // RegisterStep7 loadImage & Register
    @Published var selectedImage: UIImage? = nil
    @Published var recortedImage: UIImage? = nil
    
    let clasifier = ClasifierOfClassOfPerson()
    let authService: AuthServiceProtocol = AuthService()
    let phoneNumberValidator = PhoneNumberValidator()
    let registerService: RegisterServiceProtocol = RegisterService()

    func handleFailed(error: Error?) {
        NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
    }
}
