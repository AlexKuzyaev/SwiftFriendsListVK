//
//  LoginViewControllerTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = LoginViewController()
        UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testLoginButtonTapped() {
        sut.loginButtonTapped(UIButton())
        
        let exp = expectation(description: "presentedControllerShowed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotEqual(sut, sut.navigationController?.presentedViewController)
    }
}
