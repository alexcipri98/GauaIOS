//
//  LikeService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class LikeService {
    let db = FireBaseManager.shared.db
    
    public func getPeople(person: Person, onSuccess: @escaping ([Person]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let usersCollection = db.collection("users")
        #warning("Aquí falta filtrar por los usuarios que están a X distancia, genero, etc")
        
        usersCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("\u{274C} Error getting documents: \(error)")
                onFailure(error)
            } else {
                var result: [Person] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let currentPerson = Person(id: document.documentID,
                                               email: data["email"] as? String ?? "",
                                               name: data["name"] as? String ?? "",
                                               gender: data["gender"] as? String ?? "",
                                               sexualOrientation: data["sexualOrientation"] as? String ?? "",
                                               yearOfBorn: data["yearOfBorn"] as? Int ?? 2023,
                                               imageUrl: data["imageUrl"] as? String ?? "Error")
                    
                    FireBaseManager.shared.retrieveImageOfUser(person: currentPerson, onSuccess: { person in
                        result.append(person)
                        
                        if result.count == querySnapshot!.documents.count {
                            print("\u{1F44C} se han obtenido todos los usuarios.")
                            onSuccess(result)
                        }
                    }, onFailure: onFailure)
                }
            }
        }
    }
    
    public func likeUser(fromPerson: Person, toPerson: Person, onSuccess: @escaping (Bool?) -> Void, onFailure: @escaping (Error?) -> Void) {
        let likesCollection = db.collection("likes")
        let userId = fromPerson.id
        let likedUserId = toPerson.id
        
        let newLike = Like(id: "\(userId)_\(likedUserId)",
                           fromUserID: userId,
                           toUserID: likedUserId)
               
        likesCollection.document(newLike.id).setData([
                "fromUserID": newLike.fromUserID,
                "toUserID": newLike.toUserID
            ]) { error in
                   if let error = error {
                       print("\u{274C} Error al agregar el like: \(error.localizedDescription)")
                       onFailure(error)
                   } else {
                       self.isItMatch(fromPerson: fromPerson,
                                      toPerson: toPerson,
                                      onSuccess: onSuccess,
                                      onFailure: onFailure)
                   }
               }
    }
    
    private func isItMatch(fromPerson: Person, toPerson: Person, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        let likesCollection = db.collection("likes")
        let userId = fromPerson.id
        let likedUserId = toPerson.id
        let likeId = "\(likedUserId)_\(userId)"
        let likeDocument = likesCollection.document(likeId)
        
        likeDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("\u{274C} Error getting document: \(error)")
                onFailure(error)
            } else {
                if let document = documentSnapshot, document.exists {
                    print("isAMatch")
                    self.setMatchForUsers(fromPerson: fromPerson,
                                          toPerson: toPerson,
                                          onSuccess: onSuccess,
                                          onFailure: onFailure)
                } else {
                    print("\u{1F44C} like correcto")
                    onSuccess(false)
                }
            }
        }
    }
    
    private func setMatchForUsers(fromPerson: Person, toPerson: Person, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        let matchesCollection = db.collection("matches")
        let userId = fromPerson.id
        let likedUserId = toPerson.id
        
        let newMatch = Match(id: "\(userId)_\(likedUserId)",
                             conversation: [],
                             fromUserID: userId,
                             toUserID: likedUserId)
               
        matchesCollection.document(newMatch.id).setData([
                "fromUserID": newMatch.fromUserID,
                "toUserID": newMatch.toUserID,
                "conversation": newMatch.conversation
            ]) { error in
                   if let error = error {
                       print("\u{274C} Error al agregar el match: \(error.localizedDescription)")
                       onFailure(error)
                   } else {
                       print("\u{1F44C} match correcto")
                      onSuccess(true)
                   }
               }
    }
}
