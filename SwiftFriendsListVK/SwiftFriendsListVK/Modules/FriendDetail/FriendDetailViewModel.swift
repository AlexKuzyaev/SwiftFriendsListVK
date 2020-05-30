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

    let vkService: VKService
    let friend: Friend

    // MARK: - Initialization

    init(vkService: VKService, friend: Friend) {
        self.vkService = vkService
        self.friend = friend
        super.init()
    }
}

extension FriendDetailViewModel {

    // MARK: - Public Methods
    
    func fetchFriend() -> Observable<FriendDetail>{
        return Observable.create({ [weak self] (observer) -> Disposable in
            guard let self = self else {
                return SingleAssignmentDisposable()
            }

            self.vkService.friend(with: self.friend.id) { (result) in
                switch result {
                case .success(let friendDetail):
                    observer.on(.next(friendDetail))
                    observer.on(.completed)
                case .error(let error):
                    observer.on(.error(error))
                }
            }

            return SingleAssignmentDisposable()
        })
    }
}
