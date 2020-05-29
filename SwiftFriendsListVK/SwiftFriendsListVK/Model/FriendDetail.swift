//
//  FriendDetail.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FriendDetail: Mappable, FullNameProtocol {

    // MARK: - Constants

    private enum Constants {

        enum Date {
            static let format = "dd/MM HH:mm"
            static let locatle = "en_US_POSIX"
        }

        enum Keys {
            static let id = "id"
            static let firstName = "first_name"
            static let lastName = "last_name"
            static let avatarOrigUrl = "photo_200_orig"
            static let status = "status"
            static let time = "last_seen.time"
            static let city = "city.title"
            static let friendsCount = "counters.friends"
            static let commonCount = "common_count"
            static let followersCount = "followers_count"
            static let photosCount = "counters.photos"
            static let videosCount = "counters.videos"
        }
    }

    // MARK: - Properties

    var id: Int!
    var firstName: String!
    var lastName: String!
    var avatarOrigUrl: String!
    var status: String?
    var time: Int?
    var city: String?
    var friendsCount: Int?
    var commonCount: Int?
    var followersCount: Int?
    var photosCount: Int?
    var videosCount: Int?

    var dateTimeString: String? {
        guard let time = time else {
            return nil
        }
        let date = Date(timeIntervalSince1970: Double(time))
        let dateFormatter = DateFormatter(withFormat: Constants.Date.format,
                                          locale: Constants.Date.locatle)
        return dateFormatter.string(from: date)
    }

    // MARK: - Initialization
    
    public init?(map: Map) {}

    // MARK: - Mapping
    
    mutating public func mapping(map: Map) {
        id              <-  map[Constants.Keys.id]
        firstName       <-  map[Constants.Keys.firstName]
        lastName        <-  map[Constants.Keys.lastName]
        avatarOrigUrl   <-  map[Constants.Keys.avatarOrigUrl]
        status          <-  map[Constants.Keys.status]
        time            <-  map[Constants.Keys.time]
        city            <-  map[Constants.Keys.city]
        friendsCount    <-  map[Constants.Keys.friendsCount]
        commonCount     <-  map[Constants.Keys.commonCount]
        followersCount  <-  map[Constants.Keys.followersCount]
        photosCount     <-  map[Constants.Keys.photosCount]
        videosCount     <-  map[Constants.Keys.videosCount]
    }
}
