//
//  NSObject+Extension.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

extension NSObject {

    // MARK: -  Public Methods

    static var className: String {
        return String(describing: self.self)
    }
}
