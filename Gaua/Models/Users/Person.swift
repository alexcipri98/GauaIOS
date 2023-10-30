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
    public var prefix: String
    public var phoneNumber: String
    public var name: String
    public var gender: String
    public var genderToShow: String
    public var classOfPerson: ClassOfPerson
    public var birthDate: String
    public var imageUrl: String
    public var image: UIImage?

    init(id: String = "", description: String = "", prefix: String, phoneNumber: String, name: String, gender: String, genderToShow: String, classOfPerson: ClassOfPerson, birthDate: String, imageUrl: String, image: UIImage? = nil) {
        self.id = id
        self.description = description
        self.prefix = prefix
        self.phoneNumber = phoneNumber
        self.name = name
        self.gender = gender
        self.genderToShow = genderToShow
        self.classOfPerson = classOfPerson
        self.birthDate = birthDate
        self.imageUrl = imageUrl
        self.image = image
    }
}
