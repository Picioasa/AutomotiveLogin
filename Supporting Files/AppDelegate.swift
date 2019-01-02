//
//  AppDelegate.swift
//  AutomotiveLogin
//
//  Created by Vlad Gachi on 25/12/2018.
//  Copyright © 2018 Vlad Gachi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = AutomotiveController()
    return true
  }
}

