//
//  RegisterService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import Firebase
import FirebaseStorage

class RegisterService {
    let db = FireBaseManager.shared.db
    let storage = FireBaseManager.shared.storage

    public func register(person: Person, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
        db.collection("users").addDocument(data: [
            "name": person.name,
            "birthDate": person.birthDate,
            "gender": person.gender,
            "genderToShow": person.genderToShow,
            "classOfPerson": person.classOfPerson.rawValue,
            "imageURL" : person.imageUrl
        ]) { error in
           if let error = error {
               print("\u{274C} Error adding user: \(error.localizedDescription)")
               onFailure(error)
           } else {
               print("\u{1F44C} User added successfully!")
               onSuccess()
           }
        }
    }
    public func getVerificationID(prefix: String, phoneNumber: String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(prefix + phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    onFailure(error)
                } else {
                    if let verificationID = verificationID {
                        print("this is the verification id" + (verificationID ?? ""))

                        onSuccess(verificationID)
                    } else {
                        onFailure(nil)
                    }
                }        
            }
    }
    public func loadImage(imageData: Data, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        let uniqueID = UUID().uuidString
        let imagePath = "users/\(uniqueID).jpg"
        let imageRef = storage.reference().child(imagePath)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("\u{274C} error en la subida de la imagen")
                onFailure(error)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("\u{274C} error en la descarga de la imagen")
                    onFailure(error)
                    return
                }
                
                guard let imageUrl = url?.absoluteString else {
                    let invalidUrlError = NSError(domain: "Gaua", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image URL"])
                    print("\u{274C} error en la url de la imagen")
                    onFailure(invalidUrlError)
                    return
                }
                
                onSuccess(imageUrl)
            }
        }
    }
}
