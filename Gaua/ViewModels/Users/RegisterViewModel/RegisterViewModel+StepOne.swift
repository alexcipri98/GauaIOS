//
//  RegisterViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation

extension RegisterViewModel {
    
    func registerStepOne() {
        NavigationServiceViewModel.shared.showLoading()
        prefix = phoneNumberValidator.ensureValidPrefix(prefix)
        
        if phoneNumberValidator.isValidPhoneNumber(prefix: prefix, phoneNumber: phoneNumber) {
            requestVerificationID()
        } else {
            NavigationServiceViewModel.shared.showError(text: "register_view_phoneError".localized)
        }
    }

    private func requestVerificationID() {
        authService.getVerificationID(prefix: self.prefix,
                                      phoneNumber: phoneNumber,
                                      onSuccess: handleSuccessfulVerification,
                                      onFailure: handleFailed)
    }
    
    private func handleSuccessfulVerification(verificationID: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            self.goVerification = true
            print("Guardado verificationID en UserDefaults")
        }
        NavigationServiceViewModel.shared.hideLoading()
    }
    
}
