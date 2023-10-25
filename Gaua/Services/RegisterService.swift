//
//  RegisterService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class RegisterService {
    let db = FireBaseManager.shared.db
    let storage = FireBaseManager.shared.storage

    public func existUser(userId: String, onSuccessExist: @escaping() -> Void, onSuccessNotExist: @escaping() -> Void, onFailure: @escaping (Error?) -> Void) {
        let userRef = db.collection("users").document(userId)
        userRef.getDocument { (document, error) in
            if let error = error {
                print("\u{274C} Error checking user existence: \(error.localizedDescription)")
                onFailure(error)
                return
            }
            if let document = document, document.exists {
                onSuccessExist()
            } else {
                onSuccessNotExist()
            }
        }
    }
    
    public func register(person: Person, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
        let uniqueID = person.prefix + person.phoneNumber
        let userRef = db.collection("users").document(uniqueID)
        
        userRef.setData([
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
                        print("this is the verification id" + verificationID)

                        onSuccess(verificationID)
                    } else {
                        onFailure(nil)
                    }
                }        
            }
    }
    public func loadImage(userId: String, imageData: Data, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        let uniqueID = UUID().uuidString
        let imagePath = "users/\(userId)/\(uniqueID).jpg"
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
    
    public func getUser(userId: String, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void) {
        let usersCollection = db.collection("users")
        
        let userDocument = usersCollection.document(userId)
        
        userDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("\u{274C} Error getting document: \(error)")
                onFailure(error)
            } else {
                if let document = documentSnapshot, document.exists {
                    let data = document.data()
                    let person = Person(prefix: data?["prefix"] as? String ?? "",
                                        phoneNumber: data?["phoneNumber"] as? String ?? "",
                                        name: data?["name"] as? String ?? "",
                                        gender: data?["gender"] as? String ?? "",
                                        genderToShow: data?["genderToShow"] as? String ?? "",
                                        classOfPerson: ClassOfPerson(rawValue: data?["classOfPerson"] as? String ?? "") ?? .classA,
                                        birthDate: data?["birthDate"] as? String ?? "",
                                        imageUrl: data?["imageUrl"] as? String ?? "")
                    
                    self.retrieveImageOfUser(person: person,
                                             onSuccess: { person in
                        onSuccess(person)
                    },
                                             onFailure: onFailure)
                    
                } else {
                    let customError = NSError(domain: "",
                                              code: 409,
                                              userInfo: [NSLocalizedDescriptionKey : "Error al intentar recuperar el usuario."])
                    onFailure(customError)
                }
            }
        }
    }
    
    private func retrieveImageOfUser(person: Person, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void) {
        guard let imageUrl = URL(string: person.imageUrl) else {
            #warning("Manejar el caso cuando la URL no sea válida")
            onSuccess(person)
            return
        }

        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else {
                onSuccess(person)
                return
            }
            var mutablePerson = person
            mutablePerson.image = image
            onSuccess(mutablePerson)
        }.resume()
    }
}
