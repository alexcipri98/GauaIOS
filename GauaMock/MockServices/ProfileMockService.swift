//
//  ProfileMockService.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 24/10/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ProfileService {
    
    public func loadImage(userId: String, imageData: Data, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(true)
    }
}

