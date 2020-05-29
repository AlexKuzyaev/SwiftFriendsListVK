//
//  FriendDetailViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import RxSwift

class FriendDetailViewController: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var labelName: UILabel!
    @IBOutlet fileprivate weak var labelSeen: UILabel!
    @IBOutlet fileprivate weak var labelCity: UILabel!
    @IBOutlet fileprivate weak var labelFriends: UILabel!
    @IBOutlet fileprivate weak var labelCommon: UILabel!
    @IBOutlet fileprivate weak var labelFollowers: UILabel!
    @IBOutlet fileprivate weak var labelPhotos: UILabel!
    @IBOutlet fileprivate weak var labelVideos: UILabel!

    // MARK: - Private Properties

    private var viewModel: FriendDetailViewModel?
    private let disposeBag = DisposeBag()

    // MARK: - IBActions

    @IBAction func messageButtonTapped(_ sender: UIButton) {
        sender.animateTap()
    }

    @IBAction func friendsButtonTapped(_ sender: UIButton) {
        sender.animateTap()
    }

    // MARK: - Static Methods

    class func instance(friend: Friend) -> FriendDetailViewController? {
        let controller = UIStoryboard(name: String(describing: FriendDetailViewController.self),
                                      bundle: nil).instantiateInitialViewController() as? FriendDetailViewController
        controller?.viewModel = FriendDetailViewModel(friend: friend)
        return controller
    }

    // MARK: - Static Methods

    static func instance() -> FriendsListViewController? {
        return UIStoryboard(name: String(describing: FriendsListViewController.self),
                            bundle: nil).instantiateInitialViewController() as? FriendsListViewController
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
}

// MARK: - Private Methods

private extension FriendDetailViewController {

    func initViewModel() {
        viewModel?.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let message = self?.viewModel?.alertMessage else {
                    return
                }
                self?.showAlert(alertTitle: Strings.error, message: message)
            }
        }

        hudShowProgress()
        viewModel?.fetchFriend().subscribe { [weak self] (event) in

            guard let friendDetail = event.element else {
                return
            }

            DispatchQueue.main.async {
                self?.hudFlash(content: .success)
                if let avatarUrl = URL(string: friendDetail.avatarOrigUrl) {
                    self?.avatarImageView.sd_setImage(with: avatarUrl, completed: nil)
                }
                self?.title = friendDetail.firstName
                self?.labelName.text = friendDetail.getFullName()
                if let dateTime = friendDetail.dateTimeString {
                    self?.labelSeen.text = "last seen \(dateTime)"
                } else {
                    self?.labelSeen.text = ""
                }
                if let city = friendDetail.city {
                    self?.labelCity.text = city
                }
                if let friendsCount = friendDetail.friendsCount {
                    self?.labelFriends.text = "\(friendsCount)"
                }
                if let commonCount = friendDetail.commonCount {
                    self?.labelCommon.text = "\(commonCount)"
                }
                if let followersCount = friendDetail.followersCount {
                    self?.labelFollowers.text = "\(followersCount)"
                }
                if let photosCount = friendDetail.photosCount {
                    self?.labelPhotos.text = "\(photosCount)"
                }
                if let videosCount = friendDetail.videosCount {
                    self?.labelVideos.text = "\(videosCount)"
                }
            }

        }.disposed(by: disposeBag)
    }
}
