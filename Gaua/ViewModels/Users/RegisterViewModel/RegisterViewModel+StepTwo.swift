//
//  RegisterViewModel+StepTwo.swift
//  Gaua
//
//  Created by Alex Ciprián López on 30/10/23.
//

import Foundation

extension RegisterViewModel {
    
    func registerStepTwo() {
        authService.signInCode(verificationCode: self.verificationCode,
                           onSuccess: handleSuccessfulSingInCode,
                           onFailure: handleFailed)
    }

    private func handleSuccessfulSingInCode() {
        print("Usuario autenticado con éxito!")
        evaluateIfUserExist()
    }

    private func evaluateIfUserExist() {
        NavigationServiceViewModel.shared.showLoading()
        registerService.existUser(userId: (self.prefix + self.phoneNumber),
                                  onSuccessExist: handleSuccessfulEvaluateIfUserExist_Exist,
                                  onSuccessNotExist: handleSuccessfulEvaluateIfUserExist_NotExist,
                                  onFailure: handleFailed)
    }
    
    private func handleSuccessfulEvaluateIfUserExist_NotExist() {
        DispatchQueue.main.async {
            self.goName = true
        }
        NavigationServiceViewModel.shared.hideLoading()
    }
    
    private func handleSuccessfulEvaluateIfUserExist_Exist() {
        self.login(userId: (self.prefix + self.phoneNumber))
    }
    
    private func login(userId: String) {
        registerService.getUser(userId: userId,
                                onSuccess: handleSuccessfulLogin,
                                onFailure: handleFailed)
    }
    
    private func handleSuccessfulLogin(person: Person) {
        NavigationServiceViewModel.shared.userSession = person
        NavigationServiceViewModel.shared.hideLoading()
        NavigationServiceViewModel.shared.router.currentDestination = .main
    }
    
}
