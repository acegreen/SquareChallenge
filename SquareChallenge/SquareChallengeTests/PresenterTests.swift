//
//  PresenterTests.swift.swift
//  SquareChallengeTests
//
//  Created by Ace Green on 2022-10-18.
//

import XCTest
import AGViperKit
@testable import SquareChallenge

class PresenterTests: XCTestCase {

    private var employeesViewModel: EmployeesViewModel!

    override func setUp() {
        super.setUp()

        let expectation = self.expectation(description: "expectation")

        EmployeesPresenter.shared.updateView()
        .done { employees in
            self.employeesViewModel = employees
            expectation.fulfill()
        }.catch { error in
            XCTFail(error.localizedDescription)
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateViews() throws {

        let expectation = self.expectation(description: "expectation")
        XCTAssertNotNil(employeesViewModel)

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testEmployeeViewModelAtIndexZero() throws {

        let expectation = self.expectation(description: "expectation")

        let employeesViewModelsAtIndexZero = employeesViewModel.getEmployee(at: 0)
        XCTAssertEqual(employeesViewModelsAtIndexZero?.photoURL, URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"))
        XCTAssertEqual(employeesViewModelsAtIndexZero?.name, "Justine Mason")
        XCTAssertEqual(employeesViewModelsAtIndexZero?.bio, "Engineer on the Point of Sale team.")
        XCTAssertEqual(employeesViewModelsAtIndexZero?.team, "Point of Sale")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
