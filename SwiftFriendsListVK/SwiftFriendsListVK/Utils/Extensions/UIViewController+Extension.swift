//
//  Extension+UIViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

extension UIViewController {

    // MARK: -  Alert Methods
    
    func showAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: -  PKHUD Methods

    func hudFlash(content: HUDContentType) {
        HUD.flash(content, delay: UiConstants.hudDelay)
    }

    func hudShowProgress() {
        HUD.show(.progress)
    }
}
