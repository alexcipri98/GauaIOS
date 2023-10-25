//
//  LikeViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation
import FirebaseAuth
class LikeViewModel: ObservableObject {
    @Published var people: [Person] = []
    @Published var discardedPeople: [Person] = []
    @Published var likedPeople: [Person] = []
    @Published var isNotLikedIn: Bool = true
    @Published var errorText: String = ""
    @Published var showError: Bool = false
    var isloading = false
    private var likeService = LikeService()
    
    typealias MessageResult = Result<[Person], Error>

    var isFetching = false // Para evitar llamadas redundantes

    func processMessagesResult(_ result: MessageResult) {
        switch result {
        case .success(let fetchedPeople):
            self.people.insert(contentsOf: fetchedPeople, at: 0)
            self.isNotLikedIn = false
            
            if fetchedPeople.count == 20 {
                fetchMoreUsers()
            }
        case .failure(let error):
            self.errorText = error.localizedDescription
            self.showError = true
            self.isNotLikedIn = false
        }
    }

    func fetchMoreUsers() {
        guard !isFetching else { return }
        
        isFetching = true
        guard let person = UserSession.shared.currentUser else {
            print("Current person is nil")
            return
        }
        likeService.getPeople(initialFetch: false, person: person,
                              onSuccess: { people in
                                  self.isFetching = false
                                  self.processMessagesResult(.success(people))
                              }, onFailure: { error in
                                  self.isFetching = false
                                  self.processMessagesResult(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
                              })
    }

    func readUsers() {
        self.isFetching = true
        guard let person = UserSession.shared.currentUser else {
            print("Current person is nil")
            return
        }
        likeService.getPeople(initialFetch: true, person: person,
                              onSuccess: { people in
                                  self.isFetching = false
                                  self.processMessagesResult(.success(people))
                              }, onFailure: { error in
                                  self.isFetching = false
                                  self.processMessagesResult(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
                              })
    }

    
    func likeUser(user: Person) {
        if let index = people.firstIndex(where: { $0.id == user.id }) {
            people.remove(at: index)
            likedPeople.append(user)
            likeService.likeUser(fromPerson: UserSession.shared.currentUser!,
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
    
    func getUserDetail(onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
        RegisterService().getUser(userId: Auth.auth().currentUser?.phoneNumber ?? "errror", onSuccess: { person in
            UserSession.shared.currentUser = person
            onSuccess()
        }, onFailure: { error in
            print(error?.localizedDescription)
        })
    }
}
