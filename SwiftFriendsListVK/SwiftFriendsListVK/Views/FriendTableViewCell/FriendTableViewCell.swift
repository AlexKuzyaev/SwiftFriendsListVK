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

    // MARK: - IBOutlets
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!

    // MARK: - Public Methods
    
    func update(avatarUrl: URL?, name: String, complition: SDExternalCompletionBlock? = nil) {
        if let avatarUrl = avatarUrl {
            avatarImageView.sd_setImage(with: avatarUrl, completed: complition)
        }
        labelName.text = name
    }
}
