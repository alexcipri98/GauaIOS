//
//  AllChatsService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/7/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

struct AllChatsService {
    let db = Firestore.firestore()
    let fb = FireBaseManager.shared

    func getMatches(onSuccess: @escaping ([Match]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let matchesRef = db.collection("matches")
        var totalTransactions = 0
        
        if let user = NavigationServiceViewModel.shared.userSession {
            
            let userId = user.id
            var matches: [Match] = []
            
            matchesRef
                .whereField("fromUserID", isEqualTo: userId)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error al obtener los matches: \(error.localizedDescription)")
                        onFailure(error)
                    }
                    totalTransactions += querySnapshot?.documents.count ?? 0
                    if let querySnapshot = querySnapshot {
                        for document in querySnapshot.documents {
                            self.matchFromDocument(document, onSuccess: { match in
                                matches.append(match)
                                onSuccess(matches)
                            })
                        }
                    }
                    
                    matchesRef
                        .whereField("toUserID", isEqualTo: userId)
                        .getDocuments { (querySnapshot, error) in
                            if let error = error {
                                print("Error al obtener los matches: \(error.localizedDescription)")
                                onFailure(error)
                                return
                            }
                            
                            if let querySnapshot = querySnapshot {
                                totalTransactions += querySnapshot.documents.count
                                if totalTransactions == 0 {
                                    onSuccess(matches)
                                }
                                for document in querySnapshot.documents {
                                    self.matchFromDocument(document, onSuccess: { match in
                                        matches.append(match)
                                        onSuccess(matches)

                                    })
                                }
                            }
                        }
                }
        }
    }
    func matchFromDocument(_ document: DocumentSnapshot, onSuccess: @escaping (Match) -> Void){
        guard
            let conversation = document.data()?["conversation"] as? [String],
            let fromUserID = document.data()?["fromUserID"] as? String,
            let toUserID = document.data()?["toUserID"] as? String
        else {
            return
        }
        
        let id = document.documentID
        let currentUserID = NavigationServiceViewModel.shared.userSession?.id
        
        let otherUserID = fromUserID == currentUserID ? toUserID : fromUserID
        var match = Match(id: id,
                          conversation: conversation,
                          fromUserID: fromUserID,
                          toUserID: toUserID,
                          otherPerson: nil)
        getUser(withUserID: otherUserID,
                onSuccess: { otherUser in
                    match.otherPerson = otherUser
                    onSuccess(match)
                }, onFailure: { error in
                    print(error?.localizedDescription ?? "error")
                })
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
                                        imageUrl: data?["imageUrl"] as? String ?? "Error")*/
                   // FireBaseManager.shared.retrieveImageOfUser(person: person, onSuccess: onSuccess, onFailure: onFailure)
                } else {
                    onSuccess(nil)
                }
            }
        }
    }
}

