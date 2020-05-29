//
//  FriendsListViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import PKHUD

class FriendsListViewController: BaseViewController {

    // MARK: - IBOutlets

    private enum Constants {
        static let cellHeight: CGFloat = 80.0
    }

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Public Properties

    let viewModel = FriendsListViewModel()

    // MARK: - Private Properties
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.appColor
        
        return refreshControl
    }()

    // MARK: - Static Methods

    static func instance() -> FriendsListViewController? {
        return UIStoryboard(name: String(describing: FriendsListViewController.self),
                            bundle: nil).instantiateInitialViewController() as? FriendsListViewController
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }

    // MARK: - Other
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.fetchFriends()
    }
    
    fileprivate func showFriendsDetailController(friend: Friend) {
        guard let controller = FriendDetailViewController.instance(friend: friend) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateTitle(count: Int) {
        title = "\(count) friends"
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.className, for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath )
        cell.update(avatarUrl: cellViewModel.avatarUrl, name: cellViewModel.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfCells != 0 {
            updateTitle(count: viewModel.numberOfCells)
        }
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.friendPressed(at: indexPath)
        if let selectedFriend = viewModel.selectedFriend {
            showFriendsDetailController(friend: selectedFriend)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - Private Methods

private extension FriendsListViewController {

    func configureView() {
        tableView.register(UINib(nibName: Nib.friendTableViewCell, bundle: nil),
                           forCellReuseIdentifier: FriendTableViewCell.className)
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
    }

    func configureViewModel() {
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.hudFlash(content: .error)
                self?.refreshControl.endRefreshing()
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(alertTitle: Strings.error, message: message)
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.hudFlash(content: .success)
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }

        HUD.show(.progress)
        viewModel.fetchFriends()
    }
}
