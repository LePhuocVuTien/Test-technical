//
//  AppDelegate.swift
//  TechnicalTest
//
//  Created by iMacbook on 12/1/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Override point for customization after application launch.
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    Application.shared.configure(in: window)
    self.window = window
    
    return true
  }
  
}

