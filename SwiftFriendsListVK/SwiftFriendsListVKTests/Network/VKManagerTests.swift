//
//  VKManagerTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class VKManagerTests: XCTestCase {
    
    var sut: VKManager!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = VKManager.instance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testLogin() {
//
//        var loginSuccess = false
//        var loginError = false
//
//        let exp = self.expectation(description: "completion")
//        sut.login { (result) in
//
//            switch result {
//            case .Success(_):
//                loginSuccess = true
//                break
//            case .Error(_):
//                loginError = true
//                break
//            }
//            exp.fulfill()
//        }
//
//        waitForExpectations(timeout: 5, handler: nil)
//
//        if loginSuccess {
//            XCTAssertTrue(loginSuccess)
//        } else if loginError {
//            XCTAssertTrue(loginError)
//        } else {
//            XCTAssertTrue(false) // You need to login via VK to avoid it
//        }
//    }
//
//    func testFriendsList() {
//
//        var friendsListSuccess = false
//        var friendsListError = false
//
//        let exp = self.expectation(description: "completion")
//        sut.friendsList { (result) in
//            switch result {
//            case .Success(_):
//                friendsListSuccess = true
//                break
//            case .Error(_):
//                friendsListError = true
//                break
//            }
//            exp.fulfill()
//        }
//
//        waitForExpectations(timeout: 5, handler: nil)
//
//        if friendsListSuccess {
//            XCTAssertTrue(friendsListSuccess)
//        } else if friendsListError {
//            XCTAssertTrue(friendsListError)
//        } else {
//            XCTAssertTrue(false) // You need to login via VK to avoid it
//        }
//    }
//
//    func testFriend() {
//
//        var friendSuccess = false
//        var friendError = false
//
//        let exp = self.expectation(description: "completion")
//        sut.friend(with: 10, completion: { (result) in
//            switch result {
//            case .Success(_):
//                friendSuccess = true
//                break
//            case .Error(_):
//                friendError = true
//                break
//            }
//            exp.fulfill()
//        })
//
//        waitForExpectations(timeout: 5, handler: nil)
//
//        if friendSuccess {
//            XCTAssertTrue(friendSuccess)
//        } else if friendError {
//            XCTAssertTrue(friendError)
//        } else {
//            XCTAssertTrue(false) // You need to login via VK to avoid it
//        }
//    }
    
}
