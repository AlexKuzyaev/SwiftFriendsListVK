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
    var id: Int!
    var firstName: String!
    var lastName: String!
    var avatarUrl: String!
    
    public init?(map: Map){ }
    
    mutating public func mapping(map: Map) {
        id          <- map["id"]
        firstName   <- map["first_name"]
        lastName    <- map["last_name"]
        avatarUrl   <- map["photo_100"]
    }
}

