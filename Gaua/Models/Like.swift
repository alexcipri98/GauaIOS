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
    var conversation: [String]
    
    init(id: String, fromUserID: String, toUserID: String, conversation: [String]) {
        self.id = id
        self.fromUserID = fromUserID
        self.toUserID = toUserID
        self.conversation = conversation
    }
}
