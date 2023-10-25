//
//  Router.swift
//  Gaua
//
//  Created by Alex Ciprián López on 11/7/23.
//

import Foundation

class Router: ObservableObject {
    enum Destination {
        case login
        case main
    }
    
    @Published var currentDestination: Destination = .login
    
    func navigateTo(destination: Destination) {
        DispatchQueue.main.async {
            self.currentDestination = destination
        }
    }
}
