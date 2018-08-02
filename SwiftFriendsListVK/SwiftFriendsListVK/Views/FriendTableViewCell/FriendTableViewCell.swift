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
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    func update(avatarUrl: URL?, name: String, complition: SDExternalCompletionBlock? = nil) {
        if avatarUrl != nil {
            avatarImageView.sd_setImage(with: avatarUrl!, completed: complition)
        }
        labelName.text = name
    }
}
