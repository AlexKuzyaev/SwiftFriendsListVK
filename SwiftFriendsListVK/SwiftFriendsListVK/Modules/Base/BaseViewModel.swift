//
//  BaseViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var showAlertClosure: (()->())?
}
