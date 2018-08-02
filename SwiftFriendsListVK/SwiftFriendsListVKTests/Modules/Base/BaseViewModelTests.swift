//
//  BaseViewModelTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class BaseViewModelTests: XCTestCase {
    
    var sut: BaseViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = BaseViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testAlertMessageDidSet() {
        
        let exp = expectation(description: "fakeClosure")
        
        var closureCalled = false
        let fakeClosure = {
            closureCalled = true
            exp.fulfill()
        }
        
        sut.showAlertClosure = fakeClosure
        sut.alertMessage = "message"
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(closureCalled)
    }
}
