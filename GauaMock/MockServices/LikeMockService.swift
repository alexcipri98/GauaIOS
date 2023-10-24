//
//  LikeMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation

class LikeService {

    public func getPeople(initialFetch: Bool, person: Person, onSuccess: @escaping ([Person]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let p = Person(prefix: "+34",
                phoneNumber: "666666666",
                name: "Alex",
                gender: "Male",
                genderToShow: "Female",
                classOfPerson: .classA,
                birthDate: "16/09/1998",
                imageUrl: "url")
        onSuccess([p])
    }



    private func getIncompatibleClasses(currentClass: ClassOfPerson) -> [String] {
        switch currentClass{
        case .classA:
            return ["classA", "classC", "classD", "classE", "classG"]
        case .classB:
            return ["classB", "classC", "classD", "classF", "classH"]
        case .classC:
            return ["classA", "classB", "classD", "classF", "classG"]
        case .classD:
            return ["classA", "classB", "classC", "classE", "classH"]
        case .classE:
            return ["classA", "classD", "classE", "classF"]
        default:
            return ["classB", "classC", "classE", "classF"]
        }
    }
    
    public func likeUser(fromPerson: Person, toPerson: Person, onSuccess: @escaping (Bool?) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
    
    private func isItMatch(fromPerson: Person, toPerson: Person, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
    
    private func setMatchForUsers(fromPerson: Person, toPerson: Person, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
}

