//
//  InteractorTests.swift
//  SquareChallengeTests
//
//  Created by Ace Green on 2022-10-18.
//

import XCTest
@testable import SquareChallenge

class InteractorTests: XCTestCase {

    let interactor = EmployeesInteractor()

    private var employees: Employees!

    override func setUp() {
        super.setUp()

        let expectation = self.expectation(description: "expectation")

        interactor.fetchEmployees()
            .done { employees in
                self.employees = employees
                expectation.fulfill()
            }.catch { error in
                print(error)
            }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFetchEmployees() throws {

        let expectation = self.expectation(description: "expectation")
        XCTAssertNotNil(employees)

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testEmployeeAtIndexZero() throws {

        let expectation = self.expectation(description: "expectation")

        let employeesViewModelsAtIndexZero = employees.employees[0]
        XCTAssertEqual(employeesViewModelsAtIndexZero.uuid, "0d8fcc12-4d0c-425c-8355-390b312b909c")
        XCTAssertEqual(employeesViewModelsAtIndexZero.name, "Justine Mason")
        XCTAssertEqual(employeesViewModelsAtIndexZero.phone, "5553280123")
        XCTAssertEqual(employeesViewModelsAtIndexZero.email, "jmason.demo@squareup.com")
        XCTAssertEqual(employeesViewModelsAtIndexZero.bio, "Engineer on the Point of Sale team.")
        XCTAssertEqual(employeesViewModelsAtIndexZero.photoURLSmall, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")
        XCTAssertEqual(employeesViewModelsAtIndexZero.photoURLLarge, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")
        XCTAssertEqual(employeesViewModelsAtIndexZero.team, "Point of Sale")
        XCTAssertEqual(employeesViewModelsAtIndexZero.employeeType, "FULL_TIME")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
