//
//  NavigationContextTests.swift
//  SquareChallengeTests
//
//  Created by Ace Green on 2022-10-18.
//

import XCTest
import AGViperKit
@testable import SquareChallenge

class NavigationContextTests: XCTestCase {

    let navigationContext = EmployeesNavigationContext.main

    func testEmployeesNavigationContext() throws {

        let expectation = self.expectation(description: "expectation")

        let presenter = EmployeesPresenter.shared
        let interactor = EmployeesInteractor.shared
        let EmployeesTableViewController = UIStoryboard.employees.controller(class: EmployeesTableViewController.self)

        XCTAssertTrue(type(of: navigationContext.presenter) == type(of: presenter))
        XCTAssertTrue(type(of: navigationContext.interactor) == type(of: interactor))
        XCTAssertTrue(type(of: navigationContext.view) == type(of: EmployeesTableViewController))
        XCTAssertTrue(type(of: navigationContext.asViewController()) == type(of: EmployeesTableViewController))

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
