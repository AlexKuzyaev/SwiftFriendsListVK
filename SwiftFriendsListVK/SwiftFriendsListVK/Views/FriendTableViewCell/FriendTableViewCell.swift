//
//  FriendTableViewCell.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import SDWebImage

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    
    func update(avatarUrl: URL?, name: String) {
        if avatarUrl != nil {
            avatarImageView.sd_setImage(with: avatarUrl!, completed: nil)
        }
        labelName.text = name
    }
}
