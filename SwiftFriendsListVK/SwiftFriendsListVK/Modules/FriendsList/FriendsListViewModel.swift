//
//  FriendsListViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class FriendsListViewModel: BaseViewModel {

    // MARK: - Private Properties

    private var friends = [Friend]()
    private var cellViewModels = [FriendTableViewCellViewModel]()

    // MARK: - Properties

    let vkService: VKService
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var selectedFriend: Friend?
    var reloadTableViewClosure: EmptyClosure?

    // MARK: - Initialization

    init(vkService: VKService) {
        self.vkService = vkService
        super.init()
    }

    // MARK: - Public Methods

    func getCellViewModel(at indexPath: IndexPath ) -> FriendTableViewCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func fetchFriends() {
        vkService.friendsList { [weak self] (result) in
            switch result {
            case .success(let friends):
                self?.friends = friends
                self?.configureCellViewModels(friends: friends)
                break
            case .error(let error):
                self?.alertMessage = error.localizedDescription
                break
            }
        }
    }

    func friendPressed(at indexPath: IndexPath ){
        let friend = friends[indexPath.row]
        if !friend.isDeleted {
            self.selectedFriend = friend
        }
    }
}

// MARK: - Private Methods

private extension FriendsListViewModel {

    func configureCellViewModels(friends: [Friend]) {
        cellViewModels = friends.compactMap({ (friend) -> FriendTableViewCellViewModel? in
            return createCellViewModel(friend: friend)
        })
        reloadTableViewClosure?()
    }

    func createCellViewModel(friend: Friend) -> FriendTableViewCellViewModel? {
        let url = URL(string: friend.avatarUrl)
        return FriendTableViewCellViewModel(name: friend.getFullName(), avatarUrl: url)
    }
}
