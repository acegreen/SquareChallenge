//
//  ViewModelTests.swift
//  SquareChallengeTests
//
//  Created by Ace Green on 2022-10-18.
//

import XCTest
import AGViperKit
@testable import SquareChallenge

class ViewModelTests: XCTestCase {

    func testMockViewModel() throws {

        let expectation = self.expectation(description: "expectation")

        let mockEmployeeViewModel = EmployeeViewModel(photoURL: URL(string: "https://some.url/path1.jpg"),
                                                      name: "Eric Rogers",
                                                      team: "Seller",
                                                      bio: "A short biography describing the employee.")

        XCTAssertEqual(mockEmployeeViewModel.photoURL, URL(string: "https://some.url/path1.jpg"))
        XCTAssertEqual(mockEmployeeViewModel.name, "Eric Rogers")
        XCTAssertEqual(mockEmployeeViewModel.team, "Seller")
        XCTAssertEqual(mockEmployeeViewModel.bio, "A short biography describing the employee.")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
