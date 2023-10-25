//
//  Pub.swift
//  Gaua
//
//  Created by Alex Ciprián López on 17/9/23.
//

import Foundation

struct Pub: Identifiable, Codable {
    var id: String
    var email: String
    var name: String
    var city: String
    var comunity: String //Comunidad Ej: Madrid
    var postalCode: Int
    var address: String
}
