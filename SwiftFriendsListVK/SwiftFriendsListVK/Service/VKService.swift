//
//  VKService.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import VK_ios_sdk
import SwiftyJSON

final class VKService: NSObject {

    // MARK: - Constants

    private enum Constants {

        static let items = "items"

        enum Keys {
            static let fields = "fields"
            static let userIds = "user_ids"
        }

        enum Values {
            static let friendListFields = "id, first_name, last_name, photo_100"
            static let friendFields = "id, first_name, last_name, photo_200_orig, status, last_seen, city, friends_count, common_count, followers_count, photos_count, videos_count, counters"
        }
    }

    // MARK: - Private Properties

    private var onLogin: ResultBoolClosure?

    // MARK: - Public Methods

    func setup(appId: String) {
        guard let instance = VKSdk.initialize(withAppId: appId) else {
            return
        }
        instance.register(self)
    }
    
    func login(completion: @escaping ResultBoolClosure) {
        
        onLogin = completion
        
        let scope = [VK_PER_FRIENDS]
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                completion(.success(true))
            } else if let error = error {
                completion(.error(error))
            } else {
                VKSdk.authorize(scope)
            }
        }
    }
    
    func friendsList(completion: @escaping ResultFriendClosure) {
        
        let friendsRequest = VKApi.friends().get([
            Constants.Keys.fields: Constants.Values.friendListFields
        ])
        
        friendsRequest?.execute(resultBlock: { (response) in

            guard let responseJson = response?.json else {
                return
            }

            let json = JSON(arrayLiteral: responseJson)

            guard let items = json.first?.1.dictionary?[Constants.items]?.arrayValue else {
                completion(.error(ServiceError.responseError))
                return
            }

            let result = items.compactMap({ (item) -> Friend? in
                if let friend = Friend(JSONString: item.description) {
                    return friend
                }
                return nil
            })
            completion(.success(result))

        }, errorBlock: { (error) in

            guard let error = error else {
                return
            }

            let nsError = error as NSError
            if nsError.code != VK_API_ERROR {
                nsError.vkError.request.repeat()
                completion(.error(error))
            } else {
                completion(.error(error))
            }
        })
    }
    
    func friend(with id: Int, completion: @escaping ResultFriendDetailClosure) {
        
        let friendRequest = VKApi.users().get([
            Constants.Keys.userIds: id,
            Constants.Keys.fields: Constants.Values.friendFields
        ])
        
        friendRequest?.execute(resultBlock: { (response) in

            guard let responseJson = response?.json else {
                return
            }

            let json = JSON(arrayLiteral: responseJson)

            guard
                let first = json.array?.first?.array?.first,
                let friendDetail = FriendDetail(JSONString: first.description)
            else {
                completion(.error(ServiceError.responseError))
                return
            }

            completion(.success(friendDetail))

        }, errorBlock: { (error) in

            guard let error = error else {
                return
            }

            let nsError = error as NSError
            if nsError.code != VK_API_ERROR {
                nsError.vkError.request.repeat()
                completion(.error(error))
            } else {
                completion(.error(error))
            }
        })
    }
}

// MARK: - VKSdkDelegate

extension VKService: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if result.state == .authorized {
            onLogin?(.success(true))
        } else if let error = result.error {
            onLogin?(.error(error))
        } else {
            onLogin?(.success(false))
        }
    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult) {
        if result.state == .authorized {
            onLogin?(.success(true))
        } else {
            onLogin?(.error(result.error))
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        onLogin?(.error(ServiceError.vkAuthorizationFailed))
    }
}
