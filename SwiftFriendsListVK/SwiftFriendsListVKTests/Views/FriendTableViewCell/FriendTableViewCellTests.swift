//
//  FriendTableViewCellTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class FriendTableViewCellTests: XCTestCase {
    
    var sut: FriendTableViewCell!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UINib(nibName: "FriendTableViewCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! FriendTableViewCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testIBOutlets() {
        XCTAssertNotNil(sut.avatarImageView)
        XCTAssertNotNil(sut.labelName)
    }
    
    func testUpdate() {
        let url = URL(string: "https://pbs.twimg.com/profile_images/378800000532546226/dbe5f0727b69487016ffd67a6689e75a_400x400.jpeg")
        let name = "Cat"
        
        let exp = expectation(description: "imageLoaded")
        
        sut.update(avatarUrl: url, name: name, complition: { (image, error, cacheType, url) in
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(name, sut.labelName.text)
        XCTAssertNotNil(sut.avatarImageView.image)
    }
    
    func testUpdateUrlNil() {
        let name = "Cat"
        
        sut.update(avatarUrl: nil, name: name)
        
        XCTAssertEqual(name, sut.labelName.text)
        XCTAssertNil(sut.avatarImageView.image)
    }
}
