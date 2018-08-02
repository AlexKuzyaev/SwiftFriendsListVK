//
//  FriendsListViewControllerTests.swift
//  SwiftFriendsListVKTests
//
//  Created by Александр Кузяев on 01.08.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import XCTest
//import Quick
//import Nimble
//import Nimble_Snapshots

@testable import SwiftFriendsListVK

class FriendsListViewControllerTests: XCTestCase {
    
    var sut: FriendsListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FriendsListViewController.instance()
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testIBOutlets() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testInstance() {
        XCTAssertNotNil(FriendsListViewController.instance())
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.tableView.tableFooterView)
        XCTAssertNotNil(sut.viewModel.showAlertClosure)
        XCTAssertNotNil(sut.viewModel.reloadTableViewClosure)
    }
    
    func testUpdateTitle() {
        let count = 10
        sut.updateTitle(count: count)
        XCTAssertEqual(sut.title, "\(count) friends")
    }
}
