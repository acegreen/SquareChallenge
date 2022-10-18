//
//  AppDelegate.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let employeesViewController = EmployeesNavigationContext.main.asViewController()
        let navigationViewController = StyledNavigationController(rootViewController: employeesViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()

        return true
    }
}

