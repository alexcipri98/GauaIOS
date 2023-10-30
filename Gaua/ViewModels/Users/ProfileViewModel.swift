//
//  ProfileViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 17/7/23.
//

import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var isShowingImagePicker = false
    @Published var selectedImage: UIImage? = nil
    @Published var recortedImage: UIImage? = nil
    @Published var isShowingCropViewController: Bool = false
    private var profileService = ProfileService()
    var currentPerson: Person
    var age : Int?
    init() {
        guard let person = NavigationServiceViewModel.shared.userSession else {
            #warning("Esto luego hay que eliminarlo, pero ahora es para poder ver el preview")
            self.currentPerson = Person(prefix: "+34", phoneNumber: "634459500", name: "Alex", gender: "Male", genderToShow: "Female", classOfPerson: .classA, birthDate: "16/09/1998", imageUrl: "")
            return
            //Este error no debería ocurrir nunca bajo condiciones normales
            //fatalError("Error al inicializar ProfileViewModel sin un Person válido.")
        }
        self.currentPerson = person
        self.age = Converters.calculateAge(from: person.birthDate)
    }
    
    func loadImage() {
        guard let selectedImage = recortedImage,
              let userId = NavigationServiceViewModel.shared.userSession?.id,
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
