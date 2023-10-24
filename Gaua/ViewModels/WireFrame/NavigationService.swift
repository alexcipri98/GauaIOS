//
//  NavigationService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/10/23.
//

import Foundation

class NavigationService: ObservableObject {
    static let shared = NavigationService()
    
    let router = RouterViewModel()
    
    func navigateTo(destination: RouterViewModel.Destination) {
        router.navigateTo(destination: destination)
    }
}

