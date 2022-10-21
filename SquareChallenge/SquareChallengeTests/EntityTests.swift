//
//  EntityTests.swift
//  SquareChallengeTests
//
//  Created by Ace Green on 2022-10-18.
//

import XCTest
import AGViperKit
@testable import SquareChallenge

class EntityTests: XCTestCase {

    func testMockEmployeeEntity() throws {

        let expectation = self.expectation(description: "expectation")

        let mockEmployee = Employee(uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c",
                                    name: "Justine Mason",
                                    phone: "5553280123",
                                    email: "jmason.demo@squareup.com",
                                    bio: "Engineer on the Point of Sale team.",
                                    photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                                    photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                                    team: "Point of Sale",
                                    employeeType: "FULL_TIME")

        XCTAssertEqual(mockEmployee.uuid, "0d8fcc12-4d0c-425c-8355-390b312b909c")
        XCTAssertEqual(mockEmployee.name, "Justine Mason")
        XCTAssertEqual(mockEmployee.phone, "5553280123")
        XCTAssertEqual(mockEmployee.email, "jmason.demo@squareup.com")
        XCTAssertEqual(mockEmployee.bio, "Engineer on the Point of Sale team.")
        XCTAssertEqual(mockEmployee.photoURLSmall, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")
        XCTAssertEqual(mockEmployee.photoURLLarge, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")
        XCTAssertEqual(mockEmployee.team, "Point of Sale")
        XCTAssertEqual(mockEmployee.employeeType, "FULL_TIME")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
