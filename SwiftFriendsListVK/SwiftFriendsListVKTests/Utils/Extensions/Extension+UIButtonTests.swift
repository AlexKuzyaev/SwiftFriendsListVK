//
//  Extension+UIButtonTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class Extension_UIButtonTests: XCTestCase {
    
    var sut: UIButton!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIButton()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testTapAnimation() {
        let exp = expectation(description: "Wait for animation")
        sut.animateTap { (finished) in
            XCTAssertTrue(self.sut.transform.isIdentity)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
