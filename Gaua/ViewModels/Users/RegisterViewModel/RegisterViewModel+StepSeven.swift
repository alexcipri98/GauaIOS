//
//  RegisterViewModel+StepSeven.swift
//  Gaua
//
//  Created by Alex Ciprián López on 30/10/23.
//

import Foundation
import SwiftUI

extension RegisterViewModel {

    func loadImageAndRegister() {
        NavigationServiceViewModel.shared.showLoading()
        guard let imageData = getValidatedImageData() else {
            NavigationServiceViewModel.shared.showError(text: "register_view_imageError".localized)
            return
        }
        uploadImage(imageData: imageData)
    }
    
    private func getValidatedImageData() -> Data? {
        guard let selectedImage = recortedImage else { return nil }
        return selectedImage.jpegData(compressionQuality: 0.8)
    }
    
    private func uploadImage(imageData: Data) {
        let userId = self.prefix + self.phoneNumber
        registerService.loadImage(userId: userId,
                                  imageData: imageData,
                                  onSuccess: handleImageUploadSuccess,
                                  onFailure: handleFailed)
    }
    
    private func handleImageUploadSuccess(imageUrl: String) {
        registerUser(imageUrl: imageUrl)
    }
    
    private func registerUser(imageUrl: String) {
        let currentPerson = getPersonForRegister(imageUrl: imageUrl)
        self.registerService.register(person: currentPerson,
                                      onSuccess: handleSuccessfulRegister,
                                      onFailure: handleFailed)
    }

    private func getPersonForRegister(imageUrl: String) -> Person {
        let personClass = clasifier.calculateClassOfPerson(gender: self.gender, genderToShow: self.genderToShow)
        return Person(prefix: self.prefix,
                      phoneNumber: self.phoneNumber,
                      name: self.name,
                      gender: self.gender,
                      genderToShow: self.genderToShow,
                      classOfPerson: personClass,
                      birthDate: self.birthDate,
                      imageUrl: imageUrl)
    }
    
    private func handleSuccessfulRegister(currentPerson: Person) {
        NavigationServiceViewModel.shared.userSession = currentPerson
        NavigationServiceViewModel.shared.navigateTo(destination: .main)
        NavigationServiceViewModel.shared.hideLoading()
    }
    
}
