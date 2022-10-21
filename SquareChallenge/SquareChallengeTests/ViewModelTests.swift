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

    private var mockEmployeesViewModel: EmployeesViewModel!

    override func setUp() {
        super.setUp()

        let expectation = self.expectation(description: "expectation")

        let mockEmployeeViewModel = EmployeeViewModel(photoURL: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"),
                                                      name: "Justine Mason",
                                                      team: "Point of Sale",
                                                      bio: "Engineer on the Point of Sale team.")

        mockEmployeesViewModel = EmployeesViewModel(employeeViewModels: [mockEmployeeViewModel])
        XCTAssertNotNil(mockEmployeesViewModel)

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetEmployee() throws {

        let expectation = self.expectation(description: "expectation")

        let mockEmployeeViewModel = self.mockEmployeesViewModel.getEmployee(at: 0)
        XCTAssertEqual(mockEmployeeViewModel?.photoURL, URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"))
        XCTAssertEqual(mockEmployeeViewModel?.name, "Justine Mason")
        XCTAssertEqual(mockEmployeeViewModel?.team, "Point of Sale")
        XCTAssertEqual(mockEmployeeViewModel?.bio, "Engineer on the Point of Sale team.")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testEmployeesCount() throws {

        let expectation = self.expectation(description: "expectation")

        XCTAssertEqual(mockEmployeesViewModel.getEmployeesCount(), 1)

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
