//
//  Like.swift
//  Gaua
//
//  Created by Alex Ciprián López on 15/7/23.
//

import Foundation

struct Like: Identifiable {
    var id: String
    var fromUserID: String
    var toUserID: String
    
    init(id: String, fromUserID: String, toUserID: String) {
        self.id = id
        self.fromUserID = fromUserID
        self.toUserID = toUserID
    }
}
