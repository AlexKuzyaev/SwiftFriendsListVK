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

private let APP_ID = "6642077"

enum Result<T> {
    case Success(T)
    case Error(Error)
}

class VKManager: NSObject {
    
    static let instance = VKManager()
    private override init() {}
    
    var loginCompletion: ((Result<Bool>) -> Void)?

    func setup() {
        if let instance = VKSdk.initialize(withAppId: APP_ID) {
            instance.register(self)
        }
    }
    
    
    func login(completion: @escaping (Result<Bool>) -> Void) {
        
        loginCompletion = completion
        
        let scope = [VK_PER_FRIENDS]
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                completion(.Success(true))
            } else if error != nil {
                completion(.Error(error!))
            } else {
                VKSdk.authorize(scope)
            }
        }
    }
    
    func friendsList(completion: @escaping (Result<[Friend]>) -> Void) {
        
        let friendsRequest = VKApi.friends().get(["fields":"id, first_name, last_name, photo_100"])
        
        friendsRequest?.execute(resultBlock: { (response) in
            let json = JSON(arrayLiteral: response!.json)
            if let items = json[0].dictionary!["items"]?.arrayValue {
                let result = items.flatMap({ (item) -> Friend? in
                    if let friend = Friend(JSONString: item.description) {
                        return friend
                    }
                    return nil
                })
                completion(.Success(result))
            } else {
                completion(.Error(NSError(domain:"", code:0, userInfo:nil)))
            }
        }, errorBlock: { (error) in
            if (error! as NSError).code != VK_API_ERROR {
                (error! as NSError).vkError.request.repeat()
                completion(.Error(error!))
            } else {
                completion(.Error(error!))
            }
        })
    }
    
    func friend(with id: Int, completion: @escaping (Result<FriendDetail>) -> Void) {
        
        let friendRequest = VKApi.users().get(["user_ids": id, "fields":"id, first_name, last_name, photo_200_orig, status, last_seen, city, friends_count, common_count, followers_count, photos_count, videos_count, counters"])
        
        friendRequest?.execute(resultBlock: { (response) in
            let json = JSON(arrayLiteral: response!.json)
            if let first = json.array?.first?.array?.first {
                if let friendDetail = FriendDetail(JSONString: first.description) {
                    completion(.Success(friendDetail))
                }
                completion(.Error(NSError(domain:"", code:0, userInfo:nil)))
            } else {
                completion(.Error(NSError(domain:"", code:0, userInfo:nil)))
            }
        }, errorBlock: { (error) in
            if (error! as NSError).code != VK_API_ERROR {
                (error! as NSError).vkError.request.repeat()
                completion(.Error(error!))
            } else {
                completion(.Error(error!))
            }
        })
    }
}

extension VKManager: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.state == .authorized {
            loginCompletion?(Result.Success(true))
        } else if result.error != nil {
            loginCompletion?(Result.Error(result.error))
        }
    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
        if result.state == .authorized {
            loginCompletion?(Result.Success(true))
        } else if result.error != nil {
            loginCompletion?(Result.Error(result.error))
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
}
