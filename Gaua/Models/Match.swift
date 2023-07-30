//
//  Match.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/7/23.
//

import Foundation

struct Match {
    var id: String
    var conversation: [String]
    var fromUserID: String
    var toUserID: String
    var otherPerson: Person?
}
