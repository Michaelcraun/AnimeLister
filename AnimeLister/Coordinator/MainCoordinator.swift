//
//  MainCoordinator.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var appCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController()
        homeVC.mainCoordinator = self
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func logout() {
        LocalStorage.store.remove(for: .token)
        childCoordinators.removeAll()
        appCoordinator?.navigateToLogin()
    }
}
