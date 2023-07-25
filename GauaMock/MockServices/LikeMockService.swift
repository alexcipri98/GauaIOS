//
//  LikeMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 13/7/23.
//

import Foundation

class LikeService {
    public func getPeople(person: Person, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
}
