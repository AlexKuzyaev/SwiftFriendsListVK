//
//  Strings.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 29.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

enum Strings {
    static let error = "Error"
    static let errorUserAutorization = "User authorization failed"
    static let vkLoginError = "VK login failed"
    static let ok = "OK"
}

extension Strings {

    static func getFriends(count: Int) -> String {
        return "\(count) friends"
    }

    static func lastSeen(dateTime: String) -> String {
        return "last seen \(dateTime)"
    }
}
