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

    func testAchievementEntity() throws {

        let expectation = self.expectation(description: "expectation")

        let mockEmployee = Employee(uuid: "some-uuid",
                                    name: "Eric Rogers",
                                    phone: "5556669870",
                                    email: "erogers.demo@squareup.com",
                                    bio: "A short biography describing the employee.",
                                    photoURLSmall: "https://some.url/path1.jpg",
                                    photoURLLarge: "https://some.url/path2.jpg",
                                    team: "Seller",
                                    employeeType: "FULL_TIME")

        XCTAssertEqual(mockEmployee.uuid, "some-uuid")
        XCTAssertEqual(mockEmployee.name, "Eric Rogers")
        XCTAssertEqual(mockEmployee.phone, "5556669870")
        XCTAssertEqual(mockEmployee.email, "erogers.demo@squareup.com")
        XCTAssertEqual(mockEmployee.bio, "A short biography describing the employee.")
        XCTAssertEqual(mockEmployee.photoURLSmall, "https://some.url/path1.jpg")
        XCTAssertEqual(mockEmployee.photoURLLarge, "https://some.url/path2.jpg")
        XCTAssertEqual(mockEmployee.employeeType, "FULL_TIME")

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
