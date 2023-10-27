//
//  GauaApp.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//

import SwiftUI
import Firebase

@main
struct GauaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var navigationService = NavigationServiceViewModel.shared
       
       var body: some Scene {
           WindowGroup {
               ParentView()
                   .environmentObject(navigationService.router)
           }
       }
}
