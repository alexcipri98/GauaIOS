//
//  LoginService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//

import Foundation
import Firebase
import UIKit

class LoginService {
    let fb = FireBaseManager.shared
    
    public func login(email: String, password: String, onSuccess: @escaping (Person?) -> Void, onFailure: @escaping (Error?) -> Void, onNoVerified: @escaping () -> Void) {
        /*
        fb.auth.signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("\u{274C}" + (error?.localizedDescription ?? "Error desconocido"))
                onFailure(error)
            } else {
                if let user = result?.user {
                    if user.isEmailVerified {
                        print("\u{1F44C} Inicio de sesión exitoso")
                        self.getUser(withUserID: user.uid, onSuccess: onSuccess, onFailure: onFailure)
                    } else {
                        onNoVerified()
                        print("\u{274C} Correo electrónico no verificado")
                    }
                }
            }
        }*/
    }
    
    private func getUser(withUserID userID: String, onSuccess: @escaping (Person?) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        let usersCollection = fb.db.collection("users")
        
        let userDocument = usersCollection.document(userID)
        
        userDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("\u{274C} Error getting document: \(error)")
                onFailure(error)
            } else {
                if let document = documentSnapshot, document.exists {
                    let data = document.data()
                  /*  let person = Person(id: document.documentID,
                                        email: data?["email"] as? String ?? "",
                                        name: data?["name"] as? String ?? "",
                                        gender: data?["gender"] as? String ?? "",
                                        genderToShow: data?["genderToShow"] as? String ?? "",
                                        classOfPerson: ClassOfPerson(rawValue: data?["classOfPerson"] as? String ?? "") ?? .classA,
                                        yearOfBorn: data?["birthDay"] as? Int ?? 2023,
                                        imageUrl: data?["imageUrl"] as? String ?? "Error")
                    FireBaseManager.shared.retrieveImageOfUser(person: person, onSuccess: onSuccess, onFailure: onFailure)*/
                } else {
                    onSuccess(nil)
                }
            }
        }
    }
    
}
