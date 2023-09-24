//
//  AppDelegate.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/9/23.
//

import UIKit
import Firebase
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FireBaseManager.shared.requestNotificationPermission()

        return true
    }

}
