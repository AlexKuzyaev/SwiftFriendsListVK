//
//  Extension+UIViewControllerTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class Extension_UIViewControllerTests: XCTestCase {
    
    var sut: UIViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testAlert() {
        sut.showAlert(alertTitle: "Title", message: "Message")
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
}
