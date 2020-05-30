//
//  FriendsListViewController.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

class FriendsListViewController: BaseViewController {

    // MARK: - IBOutlets

    private enum Constants {
        static let cellHeight: CGFloat = 80.0
    }

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Public Properties

    private var viewModel: FriendsListViewModel?

    // MARK: - Private Properties
    
    private let refreshControl = UIRefreshControl()

    // MARK: - Class Methods

    class func instance(viewModel: FriendsListViewModel) -> FriendsListViewController? {
        let viewController = UIStoryboard(name: String(describing: FriendsListViewController.self),
                                          bundle: nil).instantiateInitialViewController() as? FriendsListViewController
        viewController?.viewModel = viewModel
        return viewController
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }

    // MARK: - Other
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel?.fetchFriends()
    }
    
    fileprivate func showFriendsDetailController(friend: Friend) {
        guard let vkService = viewModel?.vkService else {
            return
        }

        let viewModel = FriendDetailViewModel(vkService: vkService, friend: friend)

        guard let controller = FriendDetailViewController.instance(viewModel: viewModel) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateTitle(count: Int) {
        title = Strings.getFriends(count: count)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.className, for: indexPath) as? FriendTableViewCell,
            let cellViewModel = viewModel?.getCellViewModel(at: indexPath)
        else {
            return UITableViewCell()
        }
        cell.update(avatarUrl: cellViewModel.avatarUrl, name: cellViewModel.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
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
        viewModel?.friendPressed(at: indexPath)
        if let selectedFriend = viewModel?.selectedFriend {
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
        configureTableView()
        configureRefreshControl()
    }

    func configureTableView() {
        tableView.register(UINib(nibName: FriendTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: FriendTableViewCell.className)
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
    }

    func configureRefreshControl() {
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.appColor
    }

    func configureViewModel() {
        viewModel?.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.hudFlash(content: .error)
                self?.refreshControl.endRefreshing()
                if let message = self?.viewModel?.alertMessage {
                    self?.showAlert(alertTitle: Strings.error, message: message)
                }
            }
        }

        viewModel?.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.hudFlash(content: .success)
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }

        hudShowProgress()
        viewModel?.fetchFriends()
    }
}
