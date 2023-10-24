//
//  PubsSignInViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 19/10/23.
//

import Foundation
import FirebaseAuth
import libPhoneNumber
import SwiftUI

class PubsSignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var passWord: String = ""
    
    @Published var isLoading = false

}
