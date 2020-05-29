//
//  FriendDetailViewModel.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 25.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import RxSwift

class FriendDetailViewModel: BaseViewModel {

    // MARK: - Properties

    var friend: Friend

    // MARK: - Initialization

    init(friend: Friend) {
        self.friend = friend
        super.init()
    }
}

extension FriendDetailViewModel {

    // MARK: - Public Methods
    
    func fetchFriend() -> Observable<FriendDetail>{
        return Observable.create({ [weak self] (observer) -> Disposable in
            guard let weakSelf = self else {
                return SingleAssignmentDisposable()
            }

            VKManager.instance.friend(with: weakSelf.friend.id) { (result) in
                switch result {
                case .Success(let friendDetail):
                    observer.on(.next(friendDetail))
                    observer.on(.completed)
                case .Error(let error):
                    observer.on(.error(error))
                }
            }

            return SingleAssignmentDisposable()
        })
    }
}
