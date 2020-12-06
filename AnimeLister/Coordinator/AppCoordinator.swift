//
//  AppCoordinator.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    var childCoordinators: [Coordinator] = [Coordinator]()
    lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        guard let _ = LocalStorage.store.get(for: .token) else {
            navigateToLogin()
            return
        }
        
        let mainCoordinator = MainCoordinator(navigationController: self.navigationController)
        mainCoordinator.appCoordinator = self
        mainCoordinator.start()
    }
    
    func navigateToLogin() {
        let authorizationCoordinator = AuthorizationCoordinator(navigationController: self.navigationController)
        authorizationCoordinator.appCoordinator = self
        authorizationCoordinator.start()
    }
}
