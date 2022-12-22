//
//  ViewController.swift
//  HarryPotterApp
//
//  Created by Luis Felipe on 21/12/22.
//

import UIKit

public final class MainTabBarViewController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryLabel
        
        let charactersViewController = CharactersViewController()
        let charactersViewModel = CharactersViewModel(apiService: APIService())
        charactersViewController.viewModel = charactersViewModel
        let charactersNavigationController = UINavigationController(rootViewController: charactersViewController)
        
        let housesViewController = HousesViewController()
        let housesNavigationController = UINavigationController(rootViewController: housesViewController)
        
        let spellsViewController = SpellsViewController()
        let spellsNavigationController = UINavigationController(rootViewController: spellsViewController)
        
        charactersNavigationController.tabBarItem.image = UIImage(systemName: "person.3.fill")
        housesNavigationController.tabBarItem.image = UIImage(systemName: "house.fill")
        spellsNavigationController.tabBarItem.image = UIImage(systemName: "books.vertical.fill")
        
        charactersNavigationController.title = "Characters"
        housesNavigationController.title = "Houses"
        spellsNavigationController.title = "Spells"
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .gray
        tabBar.unselectedItemTintColor = .secondaryLabel
        
        setViewControllers([charactersNavigationController, housesNavigationController, spellsNavigationController], animated: true)
    }
}
