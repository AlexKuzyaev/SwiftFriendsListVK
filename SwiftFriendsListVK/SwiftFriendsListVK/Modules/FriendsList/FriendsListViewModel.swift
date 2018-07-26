//
//  FriendsListViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

class FriendsListViewModel: BaseViewModel {
    
    private var friends = [Friend]() {
        didSet {
            cellViewModels = friends.flatMap({ (friend) -> FriendTableViewCellViewModel? in
                return createCellViewModel(friend: friend)
            })
        }
    }
    
    private var cellViewModels = [FriendTableViewCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var selectedFriend: Friend?
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var reloadTableViewClosure: (()->())?
    
    func getCellViewModel(at indexPath: IndexPath ) -> FriendTableViewCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private func createCellViewModel(friend: Friend) -> FriendTableViewCellViewModel? {
        let url = URL(string: friend.avatarUrl)
        return FriendTableViewCellViewModel(name: friend.getFullName(), avatarUrl: url)
    }
    
    func friendPressed(at indexPath: IndexPath ){
        let friend = self.friends[indexPath.row]
        if friend.firstName != "DELETED" {
            self.selectedFriend = friend
        }
    }
}

extension FriendsListViewModel {
    
    func fetchFriends() {
        VKManager.instance.friendsList { [weak self] (result) in
            switch result {
            case .Success(let friends):
                self?.friends = friends
                break
            case .Error(let error):
                self?.alertMessage = error.localizedDescription
                break
            }
        }
    }
}
