//
//  AppDelegate.swift
//  SwiftFriendsListVK
//
//  Created by Александр Кузяев on 24.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properites

    var window: UIWindow?

    // MARK: - Public Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationBar()
        initializeRootView()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String else {
            return true
        }
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
}

// MARK: - Private Methods

private extension AppDelegate {

    func configureNavigationBar() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.appColor
        UINavigationBar.appearance().backgroundColor = UIColor.appColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

    func initializeRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.setRootViewController()
        window?.makeKeyAndVisible()
    }

    func setRootViewController() {

        let vkService = VKService()
        vkService.setup(appId: AppConstants.vkAppId)

        let loginViewModel = LoginViewModel(vkService: vkService)

        guard let loginViewController = LoginViewController.instance(viewModel: loginViewModel) else {
            return
        }

        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.navigationBar.barStyle = .black
        window?.rootViewController = navigationController
    }
}

