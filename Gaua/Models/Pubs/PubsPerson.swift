//
//  PubsPerson.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import Foundation

struct PubsPerson: Identifiable {    
    public var email: String
    public var nombre: String
    public var pubId: String
    public var rol: Rol
    public var id: String {
        email
    }
}
