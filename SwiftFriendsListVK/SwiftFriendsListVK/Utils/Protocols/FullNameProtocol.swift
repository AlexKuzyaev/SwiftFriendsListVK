//
//  FullNameProtocol.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol FullNameProtocol {
    
    var firstName: String! { get }
    var lastName: String! { get }
    
    func getFullName() -> String
}

extension FullNameProtocol {
    func getFullName() -> String {
        let firstNameExists = firstName != nil && firstName != ""
        let lastNameExists = lastName != nil && lastName != ""
        if firstNameExists && lastNameExists {
            return "\(firstName!) \(lastName!)"
        } else if firstNameExists {
            return firstName
        } else if lastNameExists {
            return lastName
        }
        return ""
    }
}
