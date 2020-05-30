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
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelSeen: UILabel!
    @IBOutlet private weak var labelCity: UILabel!
    @IBOutlet private weak var labelFriends: UILabel!
    @IBOutlet private weak var labelCommon: UILabel!
    @IBOutlet private weak var labelFollowers: UILabel!
    @IBOutlet private weak var labelPhotos: UILabel!
    @IBOutlet private weak var labelVideos: UILabel!

    // MARK: - Private Properties

    private var viewModel: FriendDetailViewModel?
    private let disposeBag = DisposeBag()

    // MARK: - IBActions

    @IBAction private func messageButtonTapped(_ sender: UIButton) {
        sender.animateTap()
    }

    @IBAction private func friendsButtonTapped(_ sender: UIButton) {
        sender.animateTap()
    }

    // MARK: - Class Methods

    class func instance(viewModel: FriendDetailViewModel) -> FriendDetailViewController? {
        let controller = UIStoryboard(name: String(describing: FriendDetailViewController.self),
                                      bundle: nil).instantiateInitialViewController() as? FriendDetailViewController
        controller?.viewModel = viewModel
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

                self?.title = friendDetail.firstName
                self?.labelName.text = friendDetail.getFullName()
                self?.labelCity.text = friendDetail.city
                self?.labelFriends.text = friendDetail.friendsCount?.toString()
                self?.labelCommon.text = friendDetail.commonCount?.toString()
                self?.labelFollowers.text = friendDetail.followersCount?.toString()
                self?.labelPhotos.text = friendDetail.photosCount?.toString()
                self?.labelVideos.text = friendDetail.videosCount?.toString()

                if let avatarUrl = URL(string: friendDetail.avatarOrigUrl) {
                    self?.avatarImageView.sd_setImage(with: avatarUrl, completed: nil)
                }

                if let dateTime = friendDetail.dateTimeString {
                    self?.labelSeen.text = Strings.lastSeen(dateTime: dateTime)
                }
            }

        }.disposed(by: disposeBag)
    }
}
