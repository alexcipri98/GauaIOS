//
//  RegisterService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import Firebase
import FirebaseAuth

class RegisterService {
    let fb = FireBaseManager.shared
    public func register(person: Person, password: String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        fb.auth.createUser(withEmail: person.email,
                               password: password,
                               completion: { result, err in
                                    if let err = err {
                                        print("\u{274C} Error en el usuario")
                                        onFailure(err)
                                    } else {
                                        print("\u{1F44C} Successfully created account with ID: \(result?.user.uid ?? "")")
                                        guard let userFirebase = result?.user else{
                                            print("\u{274C} Error")
                                            return
                                        }
                                        self.sendEmailVerification(user: userFirebase)
                                        self.addExtraUserParams(userID: userFirebase.uid, person: person, onSuccess: onSuccess, onFailure: onFailure)
                                    }
                            })
    }
    
    private func sendEmailVerification(user: User) {
        user.sendEmailVerification { error in
                if let error = error {
                    print("\u{274C}" + error.localizedDescription)
                    return
                }
                print("\u{1F44C} Successfull email")
            }
    }
    
    private func addExtraUserParams(userID: String, person: Person, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        fb.db.collection("users").document(userID).setData([
            "name": person.name,
            "yearOfBorn": person.yearOfBorn,
            "gender": person.gender,
            "genderToShow": person.genderToShow,
            "classOfPerson": person.classOfPerson.rawValue
        ]) { error in
           if let error = error {
               print("\u{274C} Error saving user data: \(error.localizedDescription)")
               onFailure(error)
           } else {
               print("\u{1F44C} User data saved successfully!")
               onSuccess(true)
           }
        }
        
    }
}
