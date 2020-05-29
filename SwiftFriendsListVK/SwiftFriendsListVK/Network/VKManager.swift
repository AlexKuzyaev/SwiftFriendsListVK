//
//  VKManager.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import VK_ios_sdk
import SwiftyJSON

class VKManager: NSObject {

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

    // MARK: - Static Properties
    
    static let instance = VKManager()

    // MARK: - Private Properties

    private var onLogin: ResultBoolClosure?

    // MARK: - Public Methods

    func setup() {
        guard let instance = VKSdk.initialize(withAppId: AppConstants.vkAppId) else {
            return
        }
        instance.register(self)
    }
    
    func login(completion: @escaping ResultBoolClosure) {
        
        onLogin = completion
        
        let scope = [VK_PER_FRIENDS]
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                completion(.Success(true))
            } else if let error = error {
                completion(.Error(error))
            } else {
                VKSdk.authorize(scope)
            }
        }
    }
    
    func friendsList(completion: @escaping ResultFriendClosure) {
        
        let friendsRequest = VKApi.friends().get([Constants.Keys.fields: Constants.Values.friendListFields])
        
        friendsRequest?.execute(resultBlock: { (response) in
            guard let responseJson = response?.json else {
                return
            }

            let json = JSON(arrayLiteral: responseJson)

            guard let items = json.first?.1.dictionary?[Constants.items]?.arrayValue else {
                completion(.Error(NSError(domain:"", code:0, userInfo:nil)))
                return
            }

            let result = items.compactMap({ (item) -> Friend? in
                if let friend = Friend(JSONString: item.description) {
                    return friend
                }
                return nil
            })
            completion(.Success(result))

        }, errorBlock: { (error) in
            guard let error = error else {
                return
            }
            let nsError = error as NSError
            if nsError.code != VK_API_ERROR {
                nsError.vkError.request.repeat()
                completion(.Error(error))
            } else {
                completion(.Error(error))
            }
        })
    }
    
    func friend(with id: Int, completion: @escaping ResultFriendDetailClosure) {
        
        let friendRequest = VKApi.users().get([Constants.Keys.userIds: id,
                                               Constants.Keys.fields: Constants.Values.friendFields])
        
        friendRequest?.execute(resultBlock: { (response) in
            guard let responseJson = response?.json else {
                return
            }
            let json = JSON(arrayLiteral: responseJson)
            if let first = json.array?.first?.array?.first {
                if let friendDetail = FriendDetail(JSONString: first.description) {
                    completion(.Success(friendDetail))
                }
                completion(.Error(NSError(domain:"", code:0, userInfo:nil)))
            } else {
                completion(.Error(NSError(domain:"", code:0, userInfo:nil)))
            }
        }, errorBlock: { (error) in
            guard let error = error else {
                return
            }
            let nsError = error as NSError
            if nsError.code != VK_API_ERROR {
                nsError.vkError.request.repeat()
                completion(.Error(error))
            } else {
                completion(.Error(error))
            }
        })
    }
}

extension VKManager: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if result.state == .authorized {
            onLogin?(.Success(true))
        } else {
            onLogin?(.Error(result.error))
        }
    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult) {
        if result.state == .authorized {
            onLogin?(.Success(true))
        } else {
            onLogin?(.Error(result.error))
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
}
