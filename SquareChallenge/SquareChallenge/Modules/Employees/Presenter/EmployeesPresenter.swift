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

    var view: ModuleView!
    var router: DefaultRouter!
    var interactor: EmployeesModuleInteractor!

    func configure(view: ModuleView, interactor: ModuleInteractor, router: ModuleRouter) {
        assert(interactor is EmployeesModuleInteractor)

        self.view = view
        self.router = router as? DefaultRouter
        self.interactor = interactor as? EmployeesModuleInteractor
    }

    func updateView() -> Promise<EmployeesViewModel> {
        return self.interactor.fetchEmployees().map { $0.asEmployeesViewModel() }
    }
}
