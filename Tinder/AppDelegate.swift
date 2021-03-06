//
//  AppDelegate.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/21.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow()
        window?.makeKeyAndVisible()
//        window?.rootViewController = HomeViewController()
//        window?.rootViewController = RegistrationViewController()
        let naviVC = UINavigationController.init(rootViewController: SettingController())
        window?.rootViewController = naviVC
        return true
    }
}
