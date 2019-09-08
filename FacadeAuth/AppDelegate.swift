//
//  AppDelegate.swift
//  FacadeAuth
//
//  Created by user on 28.06.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        print("DEBUG URL: \(url.absoluteString)")
        NotificationCenter.default.post(name: .CloseSafariNotification, object: url)
        return true
    }

}

