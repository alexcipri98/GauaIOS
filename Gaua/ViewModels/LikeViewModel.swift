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
    @Published var errorText: String = ""
    @Published var showError: Bool = false
    private var likeService = LikeService()
    let currentPerson = UserSession.shared.currentUser
    
    typealias MessageResult = Result<[Person], Error>

    func processMessagesResult(_ result: MessageResult) {
        switch result {
        case .success(let people):
            self.people = people
            self.isNotLikedIn = false
        case .failure(let error):
            self.errorText = error.localizedDescription
            self.showError = true
            self.isNotLikedIn = false
        }
    }
    
    func readUsers() {
        guard let person = currentPerson else {
            print("Current person is nil")
            return
        }
        likeService.getPeople(person: person,
                              onSuccess: { people in
                                    self.processMessagesResult(.success(people))
                                }, onFailure: { error in
                                    self.processMessagesResult(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
                                })
    }
    
    func likeUser(user: Person) {
        if let index = people.firstIndex(where: { $0.id == user.id }) {
            people.remove(at: index)
            likedPeople.append(user)
            likeService.likeUser(fromPerson: currentPerson!,
                                 toPerson: user,
                                 onSuccess: { isMatch in
                                    #warning("Falta implementar que se hace cuando es match")
                                }, onFailure: { error in
                                    self.processMessagesResult(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
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
