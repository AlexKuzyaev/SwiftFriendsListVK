//
//  FullNameProtocol.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

protocol FullNameProtocol {

    // MARK: -  Public Properties

    var firstName: String! { get }
    var lastName: String! { get }

    // MARK: -  Public Methods

    func getFullName() -> String
}

// MARK: -  Public Methods Realization

extension FullNameProtocol {

    func getFullName() -> String {
        let firstNameExists = firstName != nil && !firstName.isEmpty
        let lastNameExists = lastName != nil && !lastName.isEmpty
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
