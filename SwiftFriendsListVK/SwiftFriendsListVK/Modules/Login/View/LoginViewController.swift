//
//  ViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class LoginViewController: BaseViewController {

    // MARK: - Private Properties
    
    private var viewModel: LoginViewModel?

    // MARK: - IBActions

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        sender.animateTap()
        hudShowProgress()
        viewModel?.vkLogin()
    }

    // MARK: - Class Methods

    class func instance(viewModel: LoginViewModel) -> LoginViewController? {
        let viewController = UIStoryboard(name: String(describing: LoginViewController.self),
                                          bundle: nil).instantiateInitialViewController() as? LoginViewController
        viewController?.viewModel = viewModel
        return viewController
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

        viewModel?.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.hudFlash(content: .error)
                if let message = self?.viewModel?.alertMessage {
                    self?.showAlert(alertTitle: Strings.error, message: message)
                }
            }
        }

        viewModel?.onSuccessLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.hudFlash(content: .success)
                self?.showFriendsListController()
            }
        }
    }

    func showFriendsListController() {
        guard let vkService = viewModel?.vkService else {
            return
        }
        let viewModel = FriendsListViewModel(vkService: vkService)

        guard let controller = FriendsListViewController.instance(viewModel: viewModel) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
