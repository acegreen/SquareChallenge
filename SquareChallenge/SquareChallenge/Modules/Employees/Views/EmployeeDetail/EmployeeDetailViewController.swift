//
//  EmployeeDetailViewController.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-22.
//

import UIKit
import AGViperKit
import SDWebImage

protocol EmployeeDetailModuleView: ModuleView {}

class EmployeeDetailViewController: UIViewController, EmployeeDetailModuleView {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    var presenter: EmployeesModulePresenter!

    var viewModel: EmployeeViewModel?

    func configure(presenter: ModulePresenter) {
        assert(presenter is EmployeesModulePresenter, "presenter parameter must be of type EmployeesModulePresenter")
        self.presenter = presenter as? EmployeesModulePresenter
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyling()
        configure()
    }

    func setStyling() {
        title = NSLocalizedString("\(viewModel?.name ?? "Employee")", comment: "")
        view.backgroundColor = Constants.cashGreen
    }

    func configure() {
        guard let viewModel = viewModel else { return }
        photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        photoImageView.sd_imageIndicator?.startAnimatingIndicator()
        photoImageView.sd_setImage(with: viewModel.photoURL) { [weak self] _, _, _, _  in
            self?.photoImageView.sd_imageIndicator?.stopAnimatingIndicator()
        }

        nameLabel.text = viewModel.name
        teamLabel.text = viewModel.team.uppercased()
        bioLabel.text = viewModel.bio
        phoneLabel.text = viewModel.phone.uppercased()
        emailLabel.text = viewModel.email.uppercased()
    }

}
