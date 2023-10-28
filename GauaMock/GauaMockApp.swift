//
//  GauaMockApp.swift
//  GauaMock
//
//  Created by Alex Ciprián López on 13/7/23.
//

import SwiftUI

@main
struct GauaApp: App {

    @StateObject private var navigationService = NavigationServiceViewModel.shared
       
       var body: some Scene {
           WindowGroup {
               ParentView()
                   .environmentObject(navigationService.router)
           }
       }
}
