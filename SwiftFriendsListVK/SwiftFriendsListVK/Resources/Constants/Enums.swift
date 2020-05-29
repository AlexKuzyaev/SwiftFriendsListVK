//
//  Enums.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

// MARK: - Result

enum Result<T> {
    case Success(T)
    case Error(Error)
}
