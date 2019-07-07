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
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
    
    func navigateToForgotPassword() {
        let forgotVC = ForgotViewController()
        forgotVC.authorizationCoordinator = self
        
        navigationController.pushViewController(forgotVC, animated: true)
    }
    
    func navigateToSignup() {
        let signupVC = SignupViewController()
        signupVC.authorizationCoordinator = self
        
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func navigateToLogin() {
        navigationController.popViewController(animated: true)
    }
}
