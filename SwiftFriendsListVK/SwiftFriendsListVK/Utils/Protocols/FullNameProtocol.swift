//
//  FullName.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol FullName {
    
    var firstName: String! { get }
    var lastName: String! { get }
    
    func getFullName() -> String
}

extension FullName {
    func getFullName() -> String {
        if firstName != nil && lastName != nil {
            return "\(firstName!) \(lastName!)"
        } else if firstName != nil {
            return firstName
        } else if lastName != nil {
            return lastName
        }
        return ""
    }
}
