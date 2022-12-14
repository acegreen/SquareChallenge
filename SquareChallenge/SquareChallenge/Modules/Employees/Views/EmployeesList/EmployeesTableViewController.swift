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

class EmployeesTableViewController: UITableViewController, EmployeesModuleView {

    struct EmployeeCellIdentifier {
        static let employeeCell = "EmployeeTableViewCell"
    }

    var presenter: EmployeesModulePresenter!

    var viewModel: EmployeesViewModel? {
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
        title = NSLocalizedString("Employees", comment: "")
        tableView.backgroundColor = Constants.cashGreen

        tableView.refreshControl = UIRefreshControl()
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body), NSAttributedString.Key.foregroundColor: UIColor.white]
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...",
                                                                       attributes: attributes)
        tableView.refreshControl?.tintColor = .white
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)

        tableView.emptyDataSetView { emptyView in
            let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.white]
            let descriptionAtrributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body), NSAttributedString.Key.foregroundColor: UIColor.white]
            emptyView.titleLabelString(NSAttributedString(string: "No Employees", attributes: titleAttributes))
            emptyView.detailLabelString(NSAttributedString(string: "There is a 5 second delay to simulate an empty data", attributes: descriptionAtrributes))
            let imageConfig = UIImage.SymbolConfiguration(
                pointSize: 100, weight: .medium, scale: .default)
            emptyView.image(UIImage(systemName: "person.3.fill", withConfiguration: imageConfig))
            emptyView.imageTintColor(.white)
            // TODO: fix verticalOffset pull to refresh (https://github.com/Xiaoye220/EmptyDataSet-Swift/issues/52)
            emptyView.verticalOffset(-60)
        }
    }

    private func fetchEmployees() {
        self.viewModel = nil
        DispatchQueue.main.async {
            self.tableView.reloadEmptyDataSet()
        }
        presenter.updateView().done { [weak self] (employees: EmployeesViewModel) in
            self?.viewModel = employees
        }.catch { error in
            debugPrint(error)
            self.viewModel = nil
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
        return viewModel?.getEmployeesCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCellIdentifier.employeeCell,
                                                       for: indexPath) as? EmployeeTableViewCell,
              let employeeViewModelAtIndex = viewModel?.getEmployee(at: indexPath.row) else { return UITableViewCell() }

        cell.configure(photoURL: employeeViewModelAtIndex.photoURL,
                       name: employeeViewModelAtIndex.name,
                       team: employeeViewModelAtIndex.team,
                       bio: employeeViewModelAtIndex.bio)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let employeeViewModel = viewModel?.employeeViewModels[indexPath.row] else { return }
        presenter.navigateToEmployeeDetail(employeeViewModel: employeeViewModel)
    }
}
