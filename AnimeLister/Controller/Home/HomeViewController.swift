//
//  HomeVC.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return appTheme.statusBarStyle
    }
    
    var mainCoordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = appTheme.backgroundColor
        
        setupNavigationBar()
        setupTabBar()
    }
    
    private func setupNavigationBar() {
        var temp: UIImage?
        
        temp = nil
        let profileButton = UIButton(type: .system)
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        profileButton.backgroundColor = appTheme.buttonColor
        profileButton.clipsToBounds = true
        profileButton.contentMode = .scaleAspectFit
        profileButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        profileButton.layer.cornerRadius = 17.5
        profileButton.setImage(temp, for: .normal)
        
        // Setup any additional buttons here
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        navigationItem.rightBarButtonItems = [
            // Add any additional buttons here
        ]
    }
    
    @objc private func profileTapped() {
        let profileVC = ProfileViewContoller()
        // Do any required setup of profileVC here
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension HomeViewController: UITabBarControllerDelegate {
    private func setupTabBar() {
        let newsFeedVC = NewsFeedViewController()
        let newsFeedTab = UITabBarItem(title: "News", image: nil, selectedImage: nil)
        newsFeedVC.tabBarItem = newsFeedTab
        
        let messagesVC = MessagesListViewController()
        let messagesTab = UITabBarItem(title: "Messages", image: nil, selectedImage: nil)
        messagesVC.tabBarItem = messagesTab
        
        let animeListVC = AnimeListViewController()
        let animeListTab = UITabBarItem(title: "Anime", image: nil, selectedImage: nil)
        animeListVC.tabBarItem = animeListTab
        
        let mangaListVC = MangaListViewController()
        let mangaListTab = UITabBarItem(title: "Manga", image: nil, selectedImage: nil)
        mangaListVC.tabBarItem = mangaListTab
        
        let searchVC = SearchViewController()
        let searchTab = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        searchVC.tabBarItem = searchTab
        
        self.viewControllers = [newsFeedVC, messagesVC, animeListVC, mangaListVC, searchVC]
        self.selectedViewController = newsFeedVC
    }
}
