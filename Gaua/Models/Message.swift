//
//  Message.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
