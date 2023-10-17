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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Auth.auth().canHandle(url) {
            return true
        }
        // Tu manejo de otras URLs si es necesario
        return false
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if Auth.auth().canHandleNotification(userInfo) {
            return
        }
        // Tu código para manejar otras notificaciones, si es necesario
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
        // Tu código para manejar otras notificaciones, si es necesario
    }

}
