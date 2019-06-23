//
//  AuthorizationCoordinator.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var appCoordinator: AppCoordinator?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.authCoordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func navigateToMain() {
        let homeVC = HomeViewController()
        homeVC.mainCoordinator = MainCoordinator(navigationController: navigationController)
        
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func navigateToForgotPassword() {
        
    }
    
    func navigateToSignup() {
        
    }
}
