//
//  LikeViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation

class LikeViewModel: ObservableObject {
    @Published var people: [Person] = []
    @Published var discardedPeople: [Person] = []
    @Published var likedPeople: [Person] = []
    @Published var isNotLikedIn: Bool = true
    private var likeService = LikeService()
    let currentPerson = UserSession.shared.currentUser
    
    func readUsers() {
        guard let person = currentPerson else {
            print("Current person is nil")
            return
        }
        likeService.getPeople(person: person, onSuccess: { [weak self] peopleService in
            DispatchQueue.main.async {
                self?.people = peopleService
                self?.isNotLikedIn = false
                print("Success")
            }
        }, onFailure: { error in
            print("Register error: \(error?.localizedDescription ?? "")")
            self.isNotLikedIn = false
        })
    }
    
    func likeUser(user: Person) {
        if let index = people.firstIndex(where: { $0.id == user.id }) {
            people.remove(at: index)
            likedPeople.append(user)
            likeService.likeUser(fromPerson: currentPerson!,
                                 toPerson: user,
                                 onSuccess: { isMatch in
                
                                }, onFailure: { error in
                                    print("Register error: \(error?.localizedDescription ?? "")")
                                })
        } else {
            print("Error")
            #warning("falta implementación del error")
        }
        
    }
    
    func discardUser(user: Person) {
        if let index = people.firstIndex(where: { $0.id == user.id }) {
            people.remove(at: index)
            discardedPeople.append(user)
        } else {
            print("Error")
            #warning("Falta implementación del error")
        }
    }
}
