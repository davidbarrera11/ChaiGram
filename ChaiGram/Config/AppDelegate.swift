//
//  AppDelegate.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        let animatedViewController = AnimatedViewController()
        
        let navController = UINavigationController(rootViewController: animatedViewController)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()

        return true
    }
}

