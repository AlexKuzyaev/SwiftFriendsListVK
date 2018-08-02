//
//  FriendTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import SwiftFriendsListVK

class FriendTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMap() {
        
        struct FakeFriendData {
            let id: Int!
            let firstName: String!
            let lastName: String!
            let avatarUrl: String!
        }
        
        let fakeData = FakeFriendData(id: 1, firstName: "Alex", lastName: "Kuzyaev", avatarUrl: "url")
        
        // "{\n  \"last_name\" : \"Glushkov\",\n  \"id\" : 1837314,\n  \"first_name\" : \"Alexander\",\n  \"photo_100\" : \"https:\\/\\/pp.userapi.com\\/c633718\\/v633718314\\/1e1d5\\/IRJv1f9r5b8.jpg?ava=1\"}"
        
        let jsonString = "{\n  \"photo_100\" : \"\(fakeData.avatarUrl!)\", \n  \"last_name\" : \"\(fakeData.lastName!)\",\n  \"id\" : \(fakeData.id!),\n  \"first_name\" : \"\(fakeData.firstName!)\"\n}"
        
        let friend = Friend(JSONString: jsonString)
        
        XCTAssertNotNil(friend)
        XCTAssertEqual(friend!.id, fakeData.id)
        XCTAssertEqual(friend!.firstName, fakeData.firstName)
        XCTAssertEqual(friend!.lastName, fakeData.lastName)
        XCTAssertEqual(friend!.avatarUrl, fakeData.avatarUrl)
    }
}
