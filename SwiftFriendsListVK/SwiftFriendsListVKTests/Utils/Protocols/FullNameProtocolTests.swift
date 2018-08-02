//
//  FullNameProtocolTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class FullNameProtocolTests: XCTestCase {
    
    class FakeFullName: FullNameProtocol {
        var firstName: String!
        var lastName: String!
    }
    
    var sut: FakeFullName!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FakeFullName()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testFullNameAllNil() {
        XCTAssertEqual(sut.getFullName(), "")
    }
    
    func testFullNameAllEmpty() {
        sut.firstName = ""
        sut.lastName = ""
        XCTAssertEqual(sut.getFullName(), "")
    }
    
    func testFullNameLastNameNil() {
        sut.firstName = "Alexandr"
        sut.lastName = ""
        XCTAssertEqual(sut.getFullName(), sut.firstName)
    }
    
    func testFullNameLastNameEmpty() {
        sut.firstName = "Alexandr"
        sut.lastName = ""
        XCTAssertEqual(sut.getFullName(), sut.firstName)
    }
    
    func testFullNameFirstNameNil() {
        sut.lastName = "Kuzyaev"
        XCTAssertEqual(sut.getFullName(), sut.lastName)
    }
    
    func testFullNameFirstNameEmpty() {
        sut.firstName = ""
        sut.lastName = "Kuzyaev"
        XCTAssertEqual(sut.getFullName(), sut.lastName)
    }
    
    func testFullNameFull() {
        sut.firstName = "Alexandr"
        sut.lastName = "Kuzyaev"
        XCTAssertEqual(sut.getFullName(), "\(sut.firstName!) \(sut.lastName!)")
    }
}
