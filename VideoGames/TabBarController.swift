//
//  TabBarController.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 6.07.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [createSearchNC(),createFavoritesNC()]
        
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = GamesViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController{
        let favoritesNC = FavoritesListViewController()
        favoritesNC.title = "Favorites"
        favoritesNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesNC)
    }

}
