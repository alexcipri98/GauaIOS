//
//  ProfileService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 17/7/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ProfileService {
    
    let db = FireBaseManager.shared.db
    let storage = FireBaseManager.shared.storage
    
    public func loadImage(userId: String, imageData: Data, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        let imageName = "profile"
        let imagePath = "users/\(userId)/\(imageName).jpg"
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
                
                let userRef = self.db.collection("users").document(userId)
                userRef.updateData(["imageUrl": imageUrl]) { (error) in
                    if let error = error {
                        print("\u{274C} error al añadir la imagen al usuario")
                        onFailure(error)
                    } else {
                        print("\u{1F44C} Imagen subida y asociada al usuario")
                        onSuccess(true)
                    }
                }
            }
        }
    }
}

