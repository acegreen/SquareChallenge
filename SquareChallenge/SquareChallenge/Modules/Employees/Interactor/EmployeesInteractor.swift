//
//  EmployeesInteractor.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation
import AGViperKit
import PromiseKit

public enum EmployeesError: Error {
    case noResults

    // MARK: Override Error+Log

    var reasonString: String {
        return "\(self)"
    }
}

protocol EmployeesModuleInteractor: ModuleInteractor {
    func fetchEmployees() -> Promise<Employees>
}

class EmployeesInteractor: EmployeesModuleInteractor {

    weak var presenter: EmployeesModulePresenter?

    func configure(presenter: ModulePresenter) {
        assert(presenter is EmployeesModulePresenter)
        self.presenter = presenter as? EmployeesModulePresenter
    }

    func fetchEmployees() -> Promise<Employees> {

        #if DEBUG

        _ = Promise { result in
            getLocalObject(type: Employees.self, fromFileName: "Employees") { (object: Employees?) in
                if let employeeModel: Employees = object {
                    result.resolve(employeeModel, nil)
                } else {
                    result.resolve(nil, EmployeesError.noResults)
                }
            }
        }

        #endif

        return request(EmployeesAPIConfiguration.employees)
    }
}
