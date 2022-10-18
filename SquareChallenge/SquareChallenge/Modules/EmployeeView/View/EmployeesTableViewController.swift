//
//  EmployeesTableViewController.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import UIKit
import AGViperKit
import EmptyDataSet_Swift
import SwiftUI

protocol EmployeesModuleView: ModuleView {}

class EmployeesTableViewController: UITableViewController, EmployeesModuleView, EmptyDataSetSource, EmptyDataSetDelegate {

    struct EmployeeCellIdentifier {
        static let employeeCell = "EmployeeTableViewCell"
    }

    var presenter: EmployeesModulePresenter!

    var employeesModel: EmployeesViewModel? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
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
        fetchEmployees()
    }

    private func setStyling() {
        title = NSLocalizedString("Square Challenge", comment: "")
        tableView.backgroundColor = Constants.cashGreen
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.refreshControl = UIRefreshControl()
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body), NSAttributedString.Key.foregroundColor: UIColor.white]
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...",
                                                                       attributes: attributes)
        tableView.refreshControl?.tintColor = .white
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
    }

    private func fetchEmployees() {
        self.employeesModel = nil
        self.tableView.reloadEmptyDataSet()
        presenter.updateView().done { [weak self] (employees: EmployeesViewModel) in
            self?.employeesModel = employees
        }.catch { error in
            debugPrint(error)
            self.employeesModel = nil
            self.tableView.reloadEmptyDataSet()
        }
    }

    @objc func pullToRefreshAction() {
        self.fetchEmployees()
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

    // MARK: - EmptyDataSetSource & EmptyDataSetDelegate

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let string = "No Employees"
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSAttributedString(string: string, attributes: attributes)
    }

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let string = "There is a 5 second delay to simulate an empty data"
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body), NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSAttributedString(string: string, attributes: attributes)
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        let config = UIImage.SymbolConfiguration(
            pointSize: 100, weight: .medium, scale: .default)
        let emptyImage = UIImage(systemName: "person.fill", withConfiguration: config)
        return emptyImage
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return UIColor.white
    }

    // TODO: fix verticalOffset pull to refresh (https://github.com/Xiaoye220/EmptyDataSet-Swift/issues/52)
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
}
