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
    case detail(employeeViewModel: EmployeeViewModel)

    var presenter: ModulePresenter {
        return EmployeesPresenter()
    }

    var interactor: ModuleInteractor {
        return EmployeesInteractor()
    }

    var router: ModuleRouter {
        return DefaultRouter()
    }

    var view: ModuleView {
        switch self {
        case .main:
            return Constants.Storyboards.employees.controller(class: EmployeesTableViewController.self)
        case .detail(let employeeViewModel):
            let controller = Constants.Storyboards.employeeDetail.controller(class: EmployeeDetailViewController.self)
            controller.viewModel = employeeViewModel
            return controller
        }
    }
}
