//
//  User.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import SwiftUI

struct Person: Identifiable {
    public var id: String
    public var description: String
    public var email: String
    public var name: String
    public var gender: String
    public var sexualOrientation: String
    public var yearOfBorn: Int
    public var imageUrl: String
    public var image: UIImage?

    init(id: String = "", description: String = "", email: String, name: String, gender: String, sexualOrientation: String, yearOfBorn: Int, imageUrl: String, image: UIImage? = nil) {
        self.id = id
        self.description = description
        self.email = email
        self.name = name
        self.gender = gender
        self.sexualOrientation = sexualOrientation
        self.yearOfBorn = yearOfBorn
        self.imageUrl = imageUrl
        self.image = image
    }
}
