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
    var friend: Friend!
}

extension FriendDetailViewModel {
    
    func fetchFriend() -> Observable<FriendDetail>{
        return Observable.create({ [weak self] (observer) -> Disposable in
            if let weakSelf = self {
                VKManager.instance.friend(with: weakSelf.friend.id) { (result) in
                    switch result {
                    case .Success(let friendDetail):
                        observer.on(.next(friendDetail))
                        observer.on(.completed)
                    case .Error(let error):
                        observer.on(.error(error))
                    }
                }
            }
            return SingleAssignmentDisposable()
        })
    }
}
