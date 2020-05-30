//
//  BaseViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import VK_ios_sdk

class BaseViewController: UIViewController {

    // MARK: - UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        VKSdk.instance().uiDelegate = self
    }
}

// MARK: - VKSdkUIDelegate

extension BaseViewController: VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController) {
        hudFlash(content: .success)

        guard self.presentedViewController != nil else {
            self.present(controller, animated: true)
            return
        }
        self.dismiss(animated: true, completion: {
            DispatchQueue.main.async { [weak self] in
                self?.present(controller, animated: true)
            }
        })
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        let vkCaptchaViewController = VKCaptchaViewController()
        vkCaptchaViewController.present(in: self)
    }
}
