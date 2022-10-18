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
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFetchAchievements() throws {

        let expectation = self.expectation(description: "expectation")

        let firstEmployee = employees.employees.first
        XCTAssertNotNil(employees)
        XCTAssertEqual(firstEmployee?.uuid, "0d8fcc12-4d0c-425c-8355-390b312b909c")
        XCTAssertEqual(firstEmployee?.name, "Justine Mason")
        XCTAssertEqual(firstEmployee?.phone, "5553280123")
        XCTAssertEqual(firstEmployee?.email, "jmason.demo@squareup.com")
        XCTAssertEqual(firstEmployee?.bio, "Engineer on the Point of Sale team.")
        XCTAssertEqual(firstEmployee?.photoURLSmall, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")
        XCTAssertEqual(firstEmployee?.photoURLLarge, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")
        XCTAssertEqual(firstEmployee?.team, "Point of Sale")
        XCTAssertEqual(firstEmployee?.employeeType, "FULL_TIME")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testEmployeeViewModels() throws {

        let expectation = self.expectation(description: "expectation")

        let employeeViewModels = employees.employees.map { $0.asEmployeeViewModel() }
        XCTAssertNotNil(employeeViewModels)
        let firstEmployeeViewModel = employeeViewModels.first
        XCTAssertEqual(firstEmployeeViewModel?.photoURL, URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"))
        XCTAssertEqual(firstEmployeeViewModel?.name, "Justine Mason")
        XCTAssertEqual(firstEmployeeViewModel?.team, "Point of Sale")
        XCTAssertEqual(firstEmployeeViewModel?.bio, "Engineer on the Point of Sale team.")
        
        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testEmployeeViewModel() throws {

        let expectation = self.expectation(description: "expectation")

        let employeeViewModel = employees.employees[0].asEmployeeViewModel()
        XCTAssertNotNil(employeeViewModel)
        XCTAssertEqual(employeeViewModel.photoURL, URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"))
        XCTAssertEqual(employeeViewModel.name, "Justine Mason")
        XCTAssertEqual(employeeViewModel.team, "Point of Sale")
        XCTAssertEqual(employeeViewModel.bio, "Engineer on the Point of Sale team.")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
