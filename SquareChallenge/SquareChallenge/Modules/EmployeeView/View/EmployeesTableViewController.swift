//
//  EmployeesTableViewController.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import UIKit
import AGViperKit

protocol EmployeesModuleView: ModuleView {}

class EmployeesTableViewController: UITableViewController, EmployeesModuleView {
    
    struct EmployeeCellIdentifier {
        static let employeeCell = "EmployeeTableViewCell"
    }
    
    var presenter: EmployeesModulePresenter!

    var employeesModel: EmployeesViewModel? {
        didSet {
            title = NSLocalizedString("Square Challenge", comment: "")
            tableView.reloadData()
        }
    }
    
    func configure(presenter: ModulePresenter) {
        assert(presenter is EmployeesModulePresenter, "presenter parameter must be of type EmployeesModulePresenter")
        self.presenter = presenter as? EmployeesModulePresenter
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyling()
        fetchData()
    }

    private func setStyling() {
        tableView.backgroundColor = Constants.cashGreen
    }

    private func fetchData() {
        presenter.updateView().done { [weak self] (employees: EmployeesViewModel) in
            self?.employeesModel = employees
        }.catch { error in
            print(error)
            // TODO[XXXX]: Show error
        }
    }
    
    // MARK: - UITableViewDataSource protocol conformance

    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesModel?.getEmployeesCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCellIdentifier.employeeCell,
                                                       for: indexPath) as? EmployeeTableViewCell,
              let employeeViewModelAtIndex = employeesModel?.getEmployee(at: indexPath.row) else { return UITableViewCell() }

        cell.configure(photoURL: employeeViewModelAtIndex.photoURL,
                       name: employeeViewModelAtIndex.name,
                       team: employeeViewModelAtIndex.team,
                       bio: employeeViewModelAtIndex.bio)

        return cell
    }
}

