//
//  Extension+UIColor.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 26.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

extension UIColor {

    // MARK: -  Public Properties

    static var appColor: UIColor {
        return .RGB(97, 127, 180)
    }

    // MARK: -  Public Methods
    
    static func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return RGB(r, g, b, 1.0)
    }
    
    static func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
