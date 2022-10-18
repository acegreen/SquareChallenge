//
//  EmployeeTableViewCell.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import UIKit
import SDWebImage

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    // MARK: - Methods

    func configure(photoURL: URL?, name: String, team: String, bio: String) {

        photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        photoImageView.sd_imageIndicator?.startAnimatingIndicator()
        photoImageView.sd_setImage(with: photoURL) { [weak self] _, _, _, _  in
            self?.photoImageView.sd_imageIndicator?.stopAnimatingIndicator()
        }

        nameLabel.text = name
        teamLabel.text = team
        bioLabel.text = bio

        accessibilityIdentifier = "Emloyee \(name)"
        accessibilityLabel = "Employee \(name)"
    }
}
