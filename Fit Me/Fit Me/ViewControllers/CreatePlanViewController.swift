//
//  CreatePlanViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import UIKit
import SnapKit

class CreatePlanViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let circleLoaderView = UIView()
    let continueButton = UIButton()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 0.08)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 0.08).cgColor,
            UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.12).cgColor
        ]
        gradientLayer.locations = [0.08, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        let gradientView = UIView()
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }


            
        
        
        // Circle Loader View
        circleLoaderView.backgroundColor = .white
        circleLoaderView.layer.cornerRadius = 24
        view.addSubview(circleLoaderView)
        
        // Title Label
        titleLabel.text = "We create your training plan"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        // Subtitle Label
        subtitleLabel.text = "We create a workout according to demographic profile, activity level and interests"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        view.addSubview(subtitleLabel)
        
        // Continue Button
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 1.0)
        continueButton.layer.cornerRadius = 10
        view.addSubview(continueButton)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        circleLoaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(173.67)
            make.width.equalTo(372.66)
            make.height.equalTo(372.66)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(circleLoaderView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}
