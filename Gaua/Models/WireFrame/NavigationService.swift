//
//  NavigationService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 11/7/23.
//

import Foundation

class NavigationService: ObservableObject {
    static let shared = NavigationService()
    
    let router = Router()
    
    func navigateTo(destination: Router.Destination) {
        router.navigateTo(destination: destination)
    }
}

