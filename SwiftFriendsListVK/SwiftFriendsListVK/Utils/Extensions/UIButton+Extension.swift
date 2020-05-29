//
//  Extension+UIButton.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 26.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

extension UIButton {

    // MARK: - Constants

    private enum Constants {
        static let animationDuration: TimeInterval = 0.1
        static let transformScale: CGFloat = 0.96
    }

    // MARK: -  Public Methods
    
    func animateTap(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: Constants.transformScale,
                                                y: Constants.transformScale)
        }, completion: { finished in
            UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            }, completion: completion)
        })
    }
}
