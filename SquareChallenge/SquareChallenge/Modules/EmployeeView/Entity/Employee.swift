//
//  Employee.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation

public class Employee: Codable {
    let uuid: String
    let name: String
    let phone: String
    let email: String
    let bio: String
    let photoURLSmall: String
    let photoURLLarge: String
    let team: String
    let employeeType: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case name = "full_name"
        case phone = "phone_number"
        case email = "email_address"
        case bio = "biography"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }

    public init(uuid: String, name: String, phone: String, email: String, bio: String, photoURLSmall: String, photoURLLarge: String, team: String, employeeType: String) {
        self.uuid = uuid
        self.name = name
        self.phone = phone
        self.email = email
        self.bio = bio
        self.photoURLSmall = photoURLSmall
        self.photoURLLarge = photoURLLarge
        self.team = team
        self.employeeType = employeeType
    }

    public func getImageURL() -> URL? {
        return URL(string: photoURLSmall)
    }
}

public class Employees: Codable {
    let employees: [Employee]
}
