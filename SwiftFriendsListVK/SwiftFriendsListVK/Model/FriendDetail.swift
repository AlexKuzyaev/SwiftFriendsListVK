//
//  FriendDetail.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FriendDetail: Mappable, FullName {
    var id: Int!
    var firstName: String!
    var lastName: String!
    var avatarOrigUrl: String!
    var status: String!
    var time: Int!
    var city: String!
    var friends_count: Int!
    var common_count: Int!
    var followers_count: Int!
    var photos_count: Int!
    var videos_count: Int!
    
    public init?(map: Map){ }
    
    mutating public func mapping(map: Map) {
        id              <- map["id"]
        firstName       <- map["first_name"]
        lastName        <- map["last_name"]
        avatarOrigUrl   <- map["photo_200_orig"]
        status          <- map["status"]
        time            <- map["last_seen.time"]
        city            <- map["city.title"]
        friends_count   <- map["counters.friends"]
        common_count    <- map["common_count"]
        followers_count <- map["followers_count"]
        photos_count    <- map["counters.photos"]
        videos_count    <- map["counters.videos"]
    }
}

extension FriendDetail {
    
    func getDateTimeString() -> String? {
        if let time = time {
            let date = Date(timeIntervalSince1970: Double(time))
            let dateFormatter = DateFormatter(withFormat: "dd/MM HH:mm", locale: "en_US_POSIX")
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}
