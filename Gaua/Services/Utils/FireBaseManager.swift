//
//  FireBaseManager.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/7/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FireBaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let db : Firestore

    static let shared = FireBaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.auth.languageCode = "es"
        self.storage = Storage.storage()
        self.db = Firestore.firestore()
        super.init()
    }
    
    public func retrieveImageOfUser(person: Person, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void) {
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
