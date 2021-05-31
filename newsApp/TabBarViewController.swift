//
//  TabBarViewController.swift
//  newsApp
//
//  Created by Alperen Kişi on 31/05/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    //MARK: - VC Setted -
    let feedVC = FeedViewController()
    let favoritesVc = FavoritesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
    }
    func setupTabBar(){
        let newsController = UINavigationController(rootViewController: feedVC)
        newsController.title = "News"
        tabBar.tintColor = .black
        newsController.tabBarItem.image = UIImage(systemName: "house")
        let favoritesController = UINavigationController(rootViewController: favoritesVc)
        favoritesController.title = "Favorites"
        favoritesController.tabBarItem.image = UIImage(systemName: "heart")
        viewControllers = [newsController,favoritesController]
    }
}
