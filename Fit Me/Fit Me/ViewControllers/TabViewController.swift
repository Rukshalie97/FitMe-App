//
//  TabViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//

import Foundation
import UIKit


class TabViewController: UITabBarController {
    
    var userPref : UserPref?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User Pref \(userPref)")
        
        let homeViewController = HomeViewController()
        homeViewController.userPref =  userPref
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let profileViewController = ProfileViewController()
        profileViewController.userPref =  userPref 
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        
        let controllers = [homeViewController, profileViewController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        
        tabBar.tintColor = .purple
    }
}
