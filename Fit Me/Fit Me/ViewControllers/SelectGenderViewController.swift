//
//  SelectGenderViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-13.
//

import Foundation
import UIKit
import SnapKit

import UIKit
import SnapKit

class SelectGenderViewController: UIViewController {
    
    private let selectGenderLabel = UILabel()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSelectGenderLabel()
        setupGenderSelectionItems()
    }
    
    private func setupSelectGenderLabel() {
        selectGenderLabel.text = "Select Gender"
        selectGenderLabel.font = FontManager.shared.customFont(.semiBold, size: 26)
        view.addSubview(selectGenderLabel)
        
        selectGenderLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
    }
    
    private func setupGenderSelectionItems() {
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(selectGenderLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        let genderItems = [("🙎🏽‍♂️", "Male"), ("🙎🏽‍♀️", "Female"), ("🙎🏽", "Gender Neutral")]
        
        for genderItem in genderItems {
            let emojiLabel = UILabel()
            emojiLabel.text = genderItem.0
            emojiLabel.textAlignment = .center
            emojiLabel.backgroundColor = .blue
            emojiLabel.layer.cornerRadius = 4
            emojiLabel.clipsToBounds = true
            
            let nameLabel = UILabel()
            nameLabel.text = genderItem.1
            nameLabel.textAlignment = .left
            
            let horizontalStackView = UIStackView(arrangedSubviews: [emojiLabel, nameLabel])
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 10
            horizontalStackView.alignment = .center
            
            let itemView = UIView()
            itemView.addSubview(horizontalStackView)
            itemView.layer.cornerRadius = 4
            itemView.layer.borderWidth = 2
            itemView.layer.borderColor = UIColor.gray.cgColor
            
            stackView.addArrangedSubview(itemView)
            
            emojiLabel.snp.makeConstraints { (make) in
                make.width.height.equalTo(50)
            }
            
            horizontalStackView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            }
            
            itemView.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.height.equalTo(80)
            }
        }
        
        let continueButton = UIButton()
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(hex: "#7850BF")
        continueButton.layer.cornerRadius = 25
        
        view.addSubview(continueButton)
        
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
}
