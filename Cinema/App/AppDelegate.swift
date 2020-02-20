//
//  AppDelegate.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Override point for customization after application launch.
    // SQLite DB
    _ = try? FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil, create: true
    )
    return true
  }
  
  /**
   This method call check if a project file change and update the view.
   - Returns: Return the log of state for completion or errors.
   */

  func loadApp() {
    let completion = {
      self.window = self.window
    }

    if let currentWindow = self.window {
      UIView.transition(
        from: currentWindow,
        to: window!,
        duration: UIView.inheritedAnimationDuration,
        options: []
      ) { (_) in
        completion()
      }
    } else {
      completion()
    }
  }

  func applicationWillResignActive(_ application: UIApplication) {

  }

  func applicationDidEnterBackground(_ application: UIApplication) {

  }

  func applicationWillEnterForeground(_ application: UIApplication) {

  }

  func applicationDidBecomeActive(_ application: UIApplication) {

  }

  func applicationWillTerminate(_ application: UIApplication) {

  }
}
