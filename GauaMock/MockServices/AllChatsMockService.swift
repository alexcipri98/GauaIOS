//
//  AllChatsService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/7/23.
//

import Foundation
import UIKit

class AllChatsService {

    func getMatches(onSuccess: @escaping ([Match]) -> Void, onFailure: @escaping (Error?) -> Void) {
        var matches: [Match] = []
        let m = Match(id: "1234", conversation: ["1234"], fromUserID: "1234", toUserID: "1234")
        matches.append(m)
        onSuccess(matches)
    }
    
    private func getUser(withUserID userID: String, onSuccess: @escaping (Person?) -> Void, onFailure: @escaping (Error?) -> Void) {
        let p = Person(prefix: "+34",
                phoneNumber: "666666666",
                name: "Alex",
                gender: "Male",
                genderToShow: "Female",
                classOfPerson: .classA,
                birthDate: "16/09/1998",
                imageUrl: "url")
        onSuccess(p)
    }
}

