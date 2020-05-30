//
//  LoginViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {

    // MARK: - Private Properties

    let vkService: VKService

    // MARK: - Properties
    
    var onSuccessLogin: EmptyClosure?

    // MARK: - Initialization

    init(vkService: VKService) {
        self.vkService = vkService
        super.init()
    }

    // MARK: - Public Methods
    
    func vkLogin() {
        vkService.login { [weak self] (result) in
            switch result {
            case .success(let success):
                if success {
                    self?.onSuccessLogin?()
                } else {
                    self?.alertMessage = Strings.vkLoginError
                }
            case .error(let error):
                self?.alertMessage = error.localizedDescription
            }
        }
    }
}
