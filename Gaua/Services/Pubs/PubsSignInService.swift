//
//  PubsRegisterService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import Foundation

final class PubsSignInService: PubsSignInServiceProtocol {
    let db = FireBaseManager.shared.db
    let storage = FireBaseManager.shared.storage
    
    func getUser(email: String, onSuccess: @escaping (PubsPerson) -> Void, onFailure: @escaping (Error?) -> Void) {
        let pubsUsersCollection = db.collection("pubUsers")
        
        let userDocument = pubsUsersCollection.document(email)
        
        userDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("\u{274C} Error getting document: \(error)")
                onFailure(error)
            } else {
                if let document = documentSnapshot, document.exists {
                    let data = document.data()
                    let pubsPerson = PubsPerson(email: data?["email"] as? String ?? "",
                                               nombre: data?["nombre"] as? String ?? "",
                                               pubId: data?["pubId"] as? String ?? "",
                                               rol: Rol(rawValue: data?["rol"] as? String ?? "") ?? .boxOfficer)
                    onSuccess(pubsPerson)
                } else {
                    #warning("El siguiente error no está traducido")
                    let customError = NSError(domain: "",
                                              code: 409,
                                              userInfo: [NSLocalizedDescriptionKey : "Error al intentar recuperar el usuario."])
                    onFailure(customError)
                }
            }
        }
    }
    
}
