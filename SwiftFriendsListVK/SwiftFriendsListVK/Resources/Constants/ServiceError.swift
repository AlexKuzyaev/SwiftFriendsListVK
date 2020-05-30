//
//  ServiceError.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case vkAuthorizationFailed
    case responseError
}
