//
//  Closures.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 29.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

typealias EmptyClosure = () -> Void
typealias ResultBoolClosure = (Result<Bool>) -> Void
typealias ResultFriendClosure = (Result<[Friend]>) -> Void
typealias ResultFriendDetailClosure = (Result<FriendDetail>) -> Void
