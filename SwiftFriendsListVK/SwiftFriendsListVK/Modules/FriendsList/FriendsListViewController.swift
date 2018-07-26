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
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.appColor
        
        return refreshControl
    }()
        
    private let viewModel = FriendsListViewModel()
    private let cellReuseIdentifier = "friendTableViewCell"
    
    class func instance() -> FriendsListViewController {
        return Storyboard.main.instantiateViewController(withIdentifier: "FriendsListViewController") as! FriendsListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        initView()
        initViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initView() {
        tableView.register(UINib(nibName: Nib.friendTableViewCell, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
    }
    
    private func initViewModel() {
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                HUD.flash(.error, delay: 0.3)
                self?.refreshControl.endRefreshing()
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(alertTitle: "Error", message: message)
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                HUD.flash(.success, delay: 0.3)
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        
        HUD.show(.progress)
        viewModel.fetchFriends()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.fetchFriends()
    }
    
    fileprivate func showFriendsDetailController(friend: Friend) {
        let controller = FriendDetailViewController.instance(friend: friend)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    fileprivate func updateTitle(count: Int) {
        title = "\(count) friends"
    }
}

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? FriendTableViewCell else {
            fatalError("Cell not exists in storyboard")
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
        return 80.0
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
