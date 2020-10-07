//
//  AppDelegate.swift
//  ThirdPartyMailerExample
//
//  Created by Vincent Tourraine on 28/03/16.
//  Copyright © 2016-2020 Vincent Tourraine. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("[i] If you see `-canOpenURL: failed for URL:` errors, make sure to whitelist")
        print("    the URL schemes in your app info plist (`LSApplicationQueriesSchemes`).")

        return true
    }
}
