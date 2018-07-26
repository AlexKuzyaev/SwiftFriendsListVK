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
                    self?.labelCity.text = friendDetail.city
                    self?.labelFriends.text = "\(friendDetail.friends_count!)"
                    self?.labelCommon.text = "\(friendDetail.common_count!)"
                    self?.labelFollowers.text = "\(friendDetail.followers_count!)"
                    self?.labelPhotos.text = "\(friendDetail.photos_count!)"
                    self?.labelVideos.text = "\(friendDetail.videos_count!)"
                }
            }
        }.disposed(by: disposeBag)
    }
    
    
}
