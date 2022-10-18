//
//  EmployeesPresenter.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation
import AGViperKit
import PromiseKit

protocol EmployeesModulePresenter: ModulePresenter {
    func updateView() -> Promise<EmployeesViewModel>
}

class EmployeesPresenter: EmployeesModulePresenter {

    static let shared = EmployeesPresenter()

    var view: EmployeesModuleView!
    var router: DefaultRouter!
    var interactor: EmployeesModuleInteractor!

    func configure(view: ModuleView, interactor: ModuleInteractor, router: ModuleRouter) {
        assert(view is EmployeesModuleView)
        assert(interactor is EmployeesModuleInteractor)

        self.view = view as? EmployeesModuleView
        self.router = router as? DefaultRouter
        self.interactor = interactor as? EmployeesModuleInteractor
    }

    func updateView() -> Promise<EmployeesViewModel> {
        return self.interactor.fetchEmployees().map { $0.asEmployeesViewModel() }
    }
}

extension Employees {
    func asEmployeesViewModel() -> EmployeesViewModel {
        let employeeViewModels = employees.map { employee in
            return EmployeeViewModel(photoURL: employee.getImageURL(),
                                     name: employee.name,
                                     team: employee.team,
                                     bio: employee.bio)
        }
        return EmployeesViewModel(employeeViewModels: employeeViewModels)
    }
}

extension Employee {
    func asEmployeeViewModel() -> EmployeeViewModel {
        return EmployeeViewModel(photoURL: getImageURL(),
                                 name: name,
                                 team: team,
                                 bio: bio)
    }
}
