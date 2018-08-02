//
//  LoginViewModelTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class LoginViewModelTests: XCTestCase {
    
    var sut: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = LoginViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
//    func testVkLogin() {
//        
//        let exp = expectation(description: "fakeLogin")
//        
//        var fakeSuccessLoginCalled = false
//        let fakeSuccessLogin = {
//            fakeSuccessLoginCalled = true
//            exp.fulfill()
//        }
//        
//        var fakeShowAlertClosureCalled = false
//        let fakeShowAlertClosure = {
//            fakeShowAlertClosureCalled = true
//            exp.fulfill()
//        }
//        
//        sut.successLogin = fakeSuccessLogin
//        sut.showAlertClosure = fakeShowAlertClosure
//        sut.vkLogin()
//        
//        waitForExpectations(timeout: 5, handler: nil)
//        
//        if fakeSuccessLoginCalled {
//            XCTAssertTrue(fakeSuccessLoginCalled)
//        } else if fakeShowAlertClosureCalled {
//            XCTAssertTrue(fakeShowAlertClosureCalled)
//        } else {
//            XCTAssertTrue(false) // You need to login via VK to avoid it
//        }
//    }
}
