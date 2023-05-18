//
//  SplashScreenViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//


import UIKit
import SnapKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigateToMainScreen()
    }
    
    private func setupViews() {
        let gradientLayer = CAGradientLayer()
        let transparency = 0.15
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(hexString: "#786CFF").withAlphaComponent(0.15).cgColor,
            UIColor(hexString: "#5AC8FA").withAlphaComponent(0.12).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let appNameLabel = UILabel()
        appNameLabel.text = "FitMe"
        appNameLabel.font = UIFont.systemFont(ofSize: 30)
        appNameLabel.textColor = .white
        appNameLabel.textAlignment = .center
        view.addSubview(appNameLabel)
        
        appNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func navigateToMainScreen() {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let mainViewController = HomeViewController()
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
}

