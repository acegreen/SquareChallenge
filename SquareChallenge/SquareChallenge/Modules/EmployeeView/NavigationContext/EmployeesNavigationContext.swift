//
//  EmployeesNavigationContext.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation
import UIKit
import AGViperKit

enum EmployeesNavigationContext: NavigationContext {
    case main

    var presenter: ModulePresenter {
        return EmployeesPresenter.shared
    }

    var interactor: ModuleInteractor {
        return EmployeesInteractor.shared
    }

    var router: ModuleRouter {
        return DefaultRouter()
    }

    var view: ModuleView {
        switch self {
        case .main:
            return UIStoryboard.employees.controller(class: EmployeesTableViewController.self)
        }
    }
}
