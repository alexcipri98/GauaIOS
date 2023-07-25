//
//  UserSession.swift
//  Gaua
//
//  Created by Alex Ciprián López on 15/7/23.
//

import Foundation

class UserSession {
    static let shared = UserSession()
    
    var currentUser: Person?
    
    private init() {}
}
