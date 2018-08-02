//
//  FriendDetailTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
@testable import SwiftFriendsListVK

class FriendDetailTests: XCTestCase {
    
    var sut: FriendDetail!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FriendDetail(JSONString: "{\n  \"last_seen\" : {\n    \"platform\" : 7,\n    \"time\" : 1533109748\n  },\n  \"status\" : \"\",\n  \"city\" : {\n    \"id\" : 110,\n    \"title\" : \"Perm\"\n  },\n  \"last_name\" : \"Glushkov\",\n  \"id\" : 1837314,\n  \"first_name\" : \"Alexander\",\n  \"photo_200_orig\" : \"https:\\/\\/pp.userapi.com\\/c633718\\/v633718314\\/1e1d5\\/IRJv1f9r5b8.jpg?ava=1\",\n  \"common_count\" : 16,\n  \"followers_count\" : 140,\n  \"counters\" : {\n    \"notes\" : 25,\n    \"online_friends\" : 89,\n    \"pages\" : 23,\n    \"mutual_friends\" : 16,\n    \"videos\" : 1,\n    \"audios\" : 183,\n    \"followers\" : 140,\n    \"friends\" : 496,\n    \"photos\" : 906,\n    \"subscriptions\" : 0,\n    \"albums\" : 11\n  }\n}")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testMap() {
        
        struct FakeFriendDetailData {
            let id: Int!
            let firstName: String!
            let lastName: String!
            let avatarOrigUrl: String!
            let status: String!
            let time: Int!
            let city: String!
            let friends_count: Int!
            let common_count: Int!
            let followers_count: Int!
            let photos_count: Int!
            let videos_count: Int!
        }
        
        let fakeData = FakeFriendDetailData(id: 1, firstName: "Alex", lastName: "Kuzyaev", avatarOrigUrl: "url", status: "status", time: 1533112022085, city: "Perm", friends_count: 1, common_count: 2, followers_count: 3, photos_count: 4, videos_count: 5)
        
        // "{\n  \"last_seen\" : {\n    \"platform\" : 7,\n    \"time\" : 1533109748\n  },\n  \"status\" : \"\",\n  \"city\" : {\n    \"id\" : 110,\n    \"title\" : \"Perm\"\n  },\n  \"last_name\" : \"Glushkov\",\n  \"id\" : 1837314,\n  \"first_name\" : \"Alexander\",\n  \"photo_200_orig\" : \"https:\\/\\/pp.userapi.com\\/c633718\\/v633718314\\/1e1d5\\/IRJv1f9r5b8.jpg?ava=1\",\n  \"common_count\" : 16,\n  \"followers_count\" : 140,\n  \"counters\" : {\n    \"notes\" : 25,\n    \"online_friends\" : 89,\n    \"pages\" : 23,\n    \"mutual_friends\" : 16,\n    \"videos\" : 1,\n    \"audios\" : 183,\n    \"followers\" : 140,\n    \"friends\" : 496,\n    \"photos\" : 906,\n    \"subscriptions\" : 0,\n    \"albums\" : 11\n  }\n}"

        
        let jsonString = "{\n  \"last_seen\" : {\n    \"platform\" : 7,\n    \"time\" : \(fakeData.time!)\n  },\n  \"status\" : \"\(fakeData.status!)\",\n  \"city\" : {\n    \"id\" : 110,\n    \"title\" : \"\(fakeData.city!)\"\n  },\n  \"last_name\" : \"\(fakeData.lastName!)\",\n  \"id\" : \(fakeData.id!),\n  \"first_name\" : \"\(fakeData.firstName!)\",\n  \"photo_200_orig\" : \"\(fakeData.avatarOrigUrl!)\",\n  \"common_count\" : \(fakeData.common_count!),\n  \"followers_count\" : \(fakeData.followers_count!),\n  \"counters\" : {\n    \"notes\" : 25,\n    \"online_friends\" : 89,\n    \"pages\" : 23,\n    \"mutual_friends\" : 16,\n    \"videos\" : \(fakeData.videos_count!),\n    \"audios\" : 183,\n    \"followers\" : \(fakeData.followers_count!),\n    \"friends\" : \(fakeData.friends_count!),\n    \"photos\" : \(fakeData.photos_count!),\n    \"subscriptions\" : 0,\n    \"albums\" : 11\n  }\n}"
        
        let friendDetail = FriendDetail(JSONString: jsonString)
        
        XCTAssertNotNil(friendDetail)
        XCTAssertEqual(friendDetail!.id, fakeData.id)
        XCTAssertEqual(friendDetail!.firstName, fakeData.firstName)
        XCTAssertEqual(friendDetail!.lastName, fakeData.lastName)
        XCTAssertEqual(friendDetail!.avatarOrigUrl, fakeData.avatarOrigUrl)
        XCTAssertEqual(friendDetail!.status, fakeData.status)
        XCTAssertEqual(friendDetail!.time, fakeData.time)
        XCTAssertEqual(friendDetail!.city, fakeData.city)
        XCTAssertEqual(friendDetail!.friends_count, fakeData.friends_count)
        XCTAssertEqual(friendDetail!.common_count, fakeData.common_count)
        XCTAssertEqual(friendDetail!.followers_count, fakeData.followers_count)
        XCTAssertEqual(friendDetail!.photos_count, fakeData.photos_count)
        XCTAssertEqual(friendDetail!.videos_count, fakeData.videos_count)
    }
    
    func testGetDateTimeStringNil() {
        sut.time = nil
        XCTAssertNil(sut.getDateTimeString())
    }
    
    func testGetDateTimeStringExists() {
        sut.time = 1533112022085
        let date = Date(timeIntervalSince1970: Double(sut.time!))
        let dateFormatter = DateFormatter(withFormat: "dd/MM HH:mm", locale: "en_US_POSIX")
        let result = dateFormatter.string(from: date)
        XCTAssertEqual(result, sut.getDateTimeString())
    }
}
