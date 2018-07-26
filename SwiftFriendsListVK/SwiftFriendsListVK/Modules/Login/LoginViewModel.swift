//
//  LoginViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    var successLogin: (()->())?
    
    func vkLogin() {
        VKManager.instance.login { [weak self] (result) in
            switch result {
            case .Success(_):
                self?.successLogin?()
            case .Error(let error):
                self?.alertMessage = error.localizedDescription
            }
        }
    }
}
