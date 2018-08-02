//
//  FriendDetailViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import RxSwift
import PKHUD

class FriendDetailViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var labelName: UILabel!
    @IBOutlet fileprivate weak var labelSeen: UILabel!
    @IBOutlet fileprivate weak var labelCity: UILabel!
    @IBOutlet fileprivate weak var labelFriends: UILabel!
    @IBOutlet fileprivate weak var labelCommon: UILabel!
    @IBOutlet fileprivate weak var labelFollowers: UILabel!
    @IBOutlet fileprivate weak var labelPhotos: UILabel!
    @IBOutlet fileprivate weak var labelVideos: UILabel!
    
    var friend: Friend! {
        didSet {
            viewModel.friend = friend
        }
    }

    private let viewModel = FriendDetailViewModel()
    private let disposeBag = DisposeBag()
    
    class func instance(friend: Friend) -> FriendDetailViewController {
        let controller = Storyboard.main.instantiateViewController(withIdentifier: "FriendDetailViewController") as! FriendDetailViewController
        controller.friend = friend
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func messageButtonTapped(_ sender: UIButton) {
        sender.animateTap()
    }
    
    @IBAction func friendsButtonTapped(_ sender: UIButton) {
        sender.animateTap()
    }
    
    private func initViewModel() {
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(alertTitle: "Error", message: message)
                }
            }
        }
        
        HUD.show(.progress)
        viewModel.fetchFriend().subscribe { [weak self] (event) in
            if let friendDetail = event.element {
                DispatchQueue.main.async {
                    HUD.flash(.success, delay: 1.0)
                    if let avatarUrl = URL(string: friendDetail.avatarOrigUrl) {
                        self?.avatarImageView.sd_setImage(with: avatarUrl, completed: nil)
                    }
                    self?.title = friendDetail.firstName
                    self?.labelName.text = friendDetail.getFullName()
                    if let dateTime = friendDetail.getDateTimeString() {
                        self?.labelSeen.text = "last seen \(dateTime)"
                    } else {
                        self?.labelSeen.text = ""
                    }
                    if let city = friendDetail.city {
                        self?.labelCity.text = city
                    }
                    if let friendsCount = friendDetail.friends_count {
                        self?.labelFriends.text = "\(friendsCount)"
                    }
                    if let commonCount = friendDetail.common_count {
                        self?.labelCommon.text = "\(commonCount)"
                    }
                    if let followersCount = friendDetail.followers_count {
                        self?.labelFollowers.text = "\(followersCount)"
                    }
                    if let photosCount = friendDetail.photos_count {
                        self?.labelPhotos.text = "\(photosCount)"
                    }
                    if let videosCount = friendDetail.videos_count {
                        self?.labelVideos.text = "\(videosCount)"
                    }
                }
            }
        }.disposed(by: disposeBag)
    }
    
    
}
