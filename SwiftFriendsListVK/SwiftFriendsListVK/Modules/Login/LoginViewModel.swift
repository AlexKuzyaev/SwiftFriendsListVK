//
//  LoginViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {

    // MARK: - Properties
    
    var onSuccessLogin: EmptyClosure?

    // MARK: - Public Methods
    
    func vkLogin() {
        VKManager.instance.login { [weak self] (result) in
            switch result {
            case .Success(let success):
                if success {
                    self?.onSuccessLogin?()
                }
            case .Error(let error):
                self?.alertMessage = error.localizedDescription
            }
        }
    }
}
