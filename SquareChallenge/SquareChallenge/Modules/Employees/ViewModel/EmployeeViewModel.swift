//
//  EmployeeViewModel.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation

public class EmployeeViewModel: Codable, Equatable {
    let photoURL: URL?
    let name: String
    let team: String
    let bio: String
    let phone: String
    let email: String

    public init(photoURL: URL?, name: String, team: String, bio: String, phone: String, email: String) {
        self.photoURL = photoURL
        self.name = name
        self.team = team
        self.bio = bio
        self.phone = phone
        self.email = email
    }
}

public func == (lhs: EmployeeViewModel, rhs: EmployeeViewModel) -> Bool {
    return lhs.photoURL == rhs.photoURL &&
        lhs.name == rhs.name &&
        lhs.team == rhs.team &&
        lhs.bio == rhs.bio
}

public class EmployeesViewModel: Codable {
    let employeeViewModels: [EmployeeViewModel]

    public init(employeeViewModels: [EmployeeViewModel]) {
        self.employeeViewModels = employeeViewModels
    }

    func getEmployeesCount() -> Int? {
        return employeeViewModels.count
    }

    func getEmployee(at index: Int) -> EmployeeViewModel? {
        return employeeViewModels[index]
    }
}

extension Employees {
    func asEmployeesViewModel() -> EmployeesViewModel {
        let employeeViewModels = employees.map { employee in
            return EmployeeViewModel(photoURL: employee.getImageURL(),
                                     name: employee.name,
                                     team: employee.team,
                                     bio: employee.bio,
                                     phone: employee.phone,
                                     email: employee.email)
        }
        return EmployeesViewModel(employeeViewModels: employeeViewModels)
    }
}

extension Employee {
    func asEmployeeViewModel() -> EmployeeViewModel {
        return EmployeeViewModel(photoURL: getImageURL(),
                                 name: name,
                                 team: team,
                                 bio: bio,
                                 phone: phone,
                                 email: email)
    }
}
