//
//  TabBarViewController.swift
//  newsApp
//
//  Created by Alperen Kişi on 31/05/2021.
//

import UIKit

class MainViewController: UITabBarController {

    //MARK: - VC Setted -
    let feedVC = FeedViewController()
    let favoritesVc = FavoritesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar(){
        let newsController = UINavigationController(rootViewController: feedVC)
        newsController.navigationBar.tintColor = .black
        newsController.title = "News"
        tabBar.tintColor = .black
        newsController.tabBarItem.image = UIImage(systemName: "house")
        newsController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        let favoritesController = UINavigationController(rootViewController: favoritesVc)
        favoritesVc.favoriteNewsTableView.reloadData()
        favoritesController.title = "Favorites"
        favoritesController.tabBarItem.image = UIImage(systemName: "heart")
        favoritesController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        viewControllers = [newsController,favoritesController]
    }
}
