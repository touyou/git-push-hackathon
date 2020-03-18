//
//  AppDelegate.swift
//  GitMe
//
//  Created by 藤井陽介 on 2018/01/16.
//  Copyright © 2018 touyou. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor(named: "DarkGray")

        return true
    }

    // コールバックを受け取る
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        if url.host == "oauth-callback" {

            OAuthSwift.handle(url: url)
        }

        return true
    }
}

