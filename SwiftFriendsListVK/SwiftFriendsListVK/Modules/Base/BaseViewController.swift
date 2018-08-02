//
//  BaseViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import VK_ios_sdk
import PKHUD

class BaseViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        VKSdk.instance().uiDelegate = self
    }
}

extension BaseViewController: VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        HUD.flash(.success, delay: 0.5)
        if (self.presentedViewController != nil) {
            self.dismiss(animated: true, completion: {
                print("hide current modal controller if presents")
                DispatchQueue.main.async { [weak self] in
                    self?.present(controller, animated: true, completion: {
                        print("SFSafariViewController opened to login through a browser")
                    })
                }
            })
        } else {
            self.present(controller, animated: true, completion: {
                print("SFSafariViewController opened to login through a browser")
            })
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
