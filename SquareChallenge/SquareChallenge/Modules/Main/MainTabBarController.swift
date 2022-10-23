//
//  MainTabBarController.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-23.
//

import UIKit

class MainTabBarController: UITabBarController {

    enum TabBarType: String, CaseIterable {
        case employees
        case settings

        var title: String {
            switch self {
            case .employees:
                return "Employees"
            case .settings:
                return "Settings"
            }
        }

        var image: UIImage {
            switch self {
            case .employees:
                return UIImage(systemName: "person.fill")!
            case .settings:
                return UIImage(systemName: "gear.circle.fill")!
            }
        }

        var viewController: UIViewController {
            var controller: UIViewController!
            switch self {
            case .employees:
                controller = EmployeesNavigationContext.main.asViewController()
            case .settings:
                controller = UIViewController()
            }
            controller.tabBarItem.title = self.title
            controller.tabBarItem.image = self.image
            return controller
        }

        var styledNavigationController: UINavigationController {
            return StyledNavigationController(rootViewController: self.viewController)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        viewControllers = TabBarType.allCases.map { $0.styledNavigationController }
    }
}
