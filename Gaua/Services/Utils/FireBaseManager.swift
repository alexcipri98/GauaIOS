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
import FirebaseFunctions

final class FireBaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let db : Firestore
    let functions : Functions

    static let shared = FireBaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.auth.languageCode = "es"
        self.storage = Storage.storage()
        self.db = Firestore.firestore()
        self.functions = Functions.functions()
        super.init()
    }
    
    public func requestNotificationPermission() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { granted, error in
                if let error = error {
                    print("Error al solicitar permisos para notificaciones: \(error)")
                } else if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                        self.retrieveFCMToken(completion: {_,_ in 
                            print("bien")
                        })
                    }
                }
            }
        )
    }
    
    #warning("Falta llamar a este método desde algún sitio")
    func retrieveFCMToken(completion: @escaping (String?, Error?) -> Void) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
                completion(nil, error)
            } else if let token = token {
                print("FCM registration token: \(token)")
                #warning("El comentario a continuación es muy importante porque serviría para saber que usuario usa que dispositivo")
                // Aquí, además de llamar al completion, podrías guardar el token en Firestore asociado al usuario.
                completion(token, nil)
            }
        }
    }
    #warning("Este método se llama desde LikeViewModel pero está repetido, también existe en RegisterService")
    func retrieveImageOfUser(person: Person, onSuccess: @escaping (Person) -> Void, onFailure: @escaping (Error?) -> Void) {
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
