//
//  ViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginViewController: BaseViewController {

    // MARK: - Private Properties
    
    private let viewModel = LoginViewModel()

    // MARK: - IBActions

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        sender.animateTap()
        hudShowProgress()
        viewModel.vkLogin()
    }

    // MARK: - Static Methods

    static func instance() -> LoginViewController? {
        return UIStoryboard(name: String(describing: LoginViewController.self),
                            bundle: nil).instantiateInitialViewController() as? LoginViewController
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
}

// MARK: - Private Methods

private extension LoginViewController {

    func initViewModel() {

        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.hudFlash(content: .error)
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(alertTitle: Strings.error, message: message)
                }
            }
        }

        viewModel.onSuccessLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.hudFlash(content: .success)
                self?.showFriendsListController()
            }
        }
    }

    func showFriendsListController() {
        guard let controller = FriendsListViewController.instance() else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - VKSdkDelegate

extension LoginViewController: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if result.state == .authorized {
            
        } else if result.error != nil {
            
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        showAlert(alertTitle: Strings.error, message: Strings.errorUserAutorization)
    }
}
