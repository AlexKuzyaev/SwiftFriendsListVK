//
//  Friend.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Friend: Mappable, FullNameProtocol {

    // MARK: - Constants

    private enum Constants {
        static let deleted = "DELETED"

        enum Keys {
            static let id = "id"
            static let firstName = "first_name"
            static let lastName = "last_name"
            static let avatarUrl = "photo_100"
        }
    }

    // MARK: - Properties

    var id: Int!
    var firstName: String!
    var lastName: String!
    var avatarUrl: String!

    var isDeleted: Bool {
        return firstName == Constants.deleted
    }

    // MARK: - Initialization
    
    public init?(map: Map) {}

    // MARK: - Mapping
    
    mutating public func mapping(map: Map) {
        id          <-  map[Constants.Keys.id]
        firstName   <-  map[Constants.Keys.firstName]
        lastName    <-  map[Constants.Keys.lastName]
        avatarUrl   <-  map[Constants.Keys.avatarUrl]
    }
}

