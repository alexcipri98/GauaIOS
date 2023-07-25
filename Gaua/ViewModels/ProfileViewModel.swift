//
//  ProfileViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 17/7/23.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isShowingImagePicker = false
    @Published var selectedImage: UIImage? = nil
    @Published var recortedImage: UIImage? = nil
    @Published var isShowingCropViewController: Bool = false
    private var profileService = ProfileService()
    let currentPerson = UserSession.shared.currentUser

    
    func loadImage() {
        guard let selectedImage = recortedImage,
              let userId = UserSession.shared.currentUser?.id,
              let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        else {
            #warning("Falta controlar error")
            print("Error al obtener la imagen seleccionada")
            return
        }
        
        profileService.loadImage(userId: userId,
                                 imageData: imageData,
                                 onSuccess: {_ in
                                    print("success")
                                },
                                 onFailure: {_ in
                                    print("error")
                                })
       
    }

    func showCrop() {
        self.isShowingCropViewController = true
    }
}
