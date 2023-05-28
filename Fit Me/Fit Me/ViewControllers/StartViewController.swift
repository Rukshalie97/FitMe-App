//
//  ViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-13.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        
        //UserDefaults.standard.set(false, forKey: "isLogged")
        
            checkLoginStatus()
        }
        
        private func checkLoginStatus() {
            let isLogged = UserDefaults.standard.bool(forKey: "isLogged")
            
            
            
            if isLogged {
                navigateToHomeViewController()
            } else {
                navigateToLoginViewController()
            }
        }
        
        private func navigateToHomeViewController() {
            let homeVC = TabViewController()
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true)
        }
        
        private func navigateToLoginViewController() {
            let loginVC = SignUpViewController()
            loginVC.modalPresentationStyle = .fullScreen
            //present(loginVC, animated: true, completion: nil)
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }


}

