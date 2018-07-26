//
//  ViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import PKHUD
import VK_ios_sdk

class LoginViewController: BaseViewController {
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        sender.animateTap()
        HUD.show(.progress)
        viewModel.vkLogin()
    }
    
    private func initViewModel() {
        
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                HUD.flash(.error, delay: 0.5)
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(alertTitle: "Error", message: message)
                }
            }
        }
        
        viewModel.successLogin = { [weak self] in
            DispatchQueue.main.async {
                HUD.flash(.success, delay: 0.5)
                self?.showFriendsListController()
            }
        }
    }
    
    private func showFriendsListController() {
        let controller = FriendsListViewController.instance()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LoginViewController: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.state == .authorized {
            
        } else if result.error != nil {
            
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
}
