//
//  EmployeesAPIConfiguration.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import AGViperKit

enum EmployeesAPIConfiguration: APIConfiguration {
    
    case employees

    var accessToken: String? {
        return nil
    }
    
    var baseURLString: String {
        return "https://s3.amazonaws.com/"
    }

    var path: URLPath {
        switch self {
        case .employees:
            return URLPath(tokenPath: "sq-mobile-interview/employees.json")
        }
    }
}
