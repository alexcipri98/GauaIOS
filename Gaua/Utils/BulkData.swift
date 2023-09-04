//
//  BulkData.swift
//  Gaua
//
//  Created by Alex Ciprián López on 17/8/23.
//

import Foundation
import FirebaseFirestore

class BulkData {

    func randomClassOfPerson() -> String {
        return ["classA", "classB", "classC", "classD", "classE", "classF", "classG", "classE"].randomElement()!
    }

    func randomGender() -> String {
        return ["female", "male", "other"].randomElement()!
    }

    func randomGenderToShow() -> String {
        return ["male", "female", "both"].randomElement()!
    }

    func randomName() -> String {
        let firstNames = ["John", "Jane", "Alex", "Emily", "Chris", "Katie"]
        let lastNames = ["Doe", "Smith", "Brown", "Johnson", "Williams", "Jones"]
        return "\(firstNames.randomElement()!) \(lastNames.randomElement()!)"
    }

    func randomYearOfBorn() -> Int {
        return Int.random(in: 1950...2005)
    }

    func randomImageUrl() -> String {
        let urls = [
            "https://firebasestorage.googleapis.com:443/v0/b/gaua-alex.appspot.com/o/users%2Fb6iR8acK24eBie7dx8tDWXzeopo2%2Fprofile.jpg?alt=media&token=ccc59cf0-3e15-421a-854d-1d71b8413187",
            "https://firebasestorage.googleapis.com:443/v0/b/gaua-alex.appspot.com/o/users%2FkWXJejXOROPTJwyaa8H7F7L2f9z2%2Fprofile.jpg?alt=media&token=c9d82474-b086-4198-af23-3f86ff68032c"
        ]
        return urls.randomElement()!
    }

    func addUserToFirestore() {
        let db = Firestore.firestore()
        for _ in 1...100 {
            let user = [
                "classOfPerson": randomClassOfPerson(),
                "gender": randomGender(),
                "genderToShow": randomGenderToShow(),
                "name": randomName(),
                "yearOfBorn": randomYearOfBorn(),
                "imageUrl": randomImageUrl()
            ] as [String : Any]
            
            db.collection("users").addDocument(data: user) { error in
                if let error = error {
                    print("Error adding user: \(error)")
                } else {
                    print("User added successfully!")
                }
            }
        }
    }


}
