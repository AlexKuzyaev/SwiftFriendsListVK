//
//  BaseViewControllerTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
import VK_ios_sdk
@testable import SwiftFriendsListVK

class BaseViewControllerTests: XCTestCase {
    
    var sut: BaseViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = BaseViewController()
        UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testVkSdkShouldPresent() {
        
        let controllerToPresentViaVkSdk = UIViewController()
        sut.vkSdkShouldPresent(controllerToPresentViaVkSdk)
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertEqual(controllerToPresentViaVkSdk, sut.presentedViewController)
    }
    
    func testVkSdkShouldPresentWithPresentedController() {
        
        let exp = expectation(description: "vkSdkPresentedController")
        
        let controllerToPresent = UIViewController()
        let controllerToPresentViaVkSdk = UIViewController()

        sut.present(controllerToPresent, animated: false) { [weak self] in
            DispatchQueue.main.async {
                self?.sut.vkSdkShouldPresent(controllerToPresentViaVkSdk)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    exp.fulfill()
                })
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertEqual(controllerToPresentViaVkSdk, sut.presentedViewController)
        XCTAssertNotEqual(controllerToPresent, sut.presentedViewController)
    }
    
    func testVkSdkNeedCaptchaEnter() {
        let error = VKError()
        sut.vkSdkNeedCaptchaEnter(error)
        XCTAssertTrue(true)
    }
    
}
