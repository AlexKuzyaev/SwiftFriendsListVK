//
//  Extension+UIButton.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 26.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

extension UIButton {
    
    func animateTap() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }, completion: { finish in
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            })
        })
    }
}
