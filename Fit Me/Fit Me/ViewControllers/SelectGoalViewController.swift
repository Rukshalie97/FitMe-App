//
//  SelectGoalViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-14.
//

import Foundation
import UIKit
import SnapKit

class SelectGoalViewController: UIViewController {
    let titleLabel = UILabel()
    
    struct Item: Identifiable {
        var id = UUID().uuidString
        var icon: String
        var label: String
    }
    
    let items: [Item] = [Item(icon: "🌿", label: "Keep Fit"),
                         Item(icon: "🏋🏽", label: "Build Muscle Mass"),
                         Item(icon: "💪🏽", label: "Get Strong"),
                         Item(icon: "👟", label: "Loose Weight")]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        // Remove the local declaration of titleLabel
        titleLabel.text = "Select Goal"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        var previousItemView: UIView? = nil
        
        for item in items {
            let itemView = createItemView(item: item)
            view.addSubview(itemView)
            
            itemView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(80)
                
                if let previousItemView = previousItemView {
                    make.top.equalTo(previousItemView.snp.bottom).offset(10)
                } else {
                    make.top.equalTo(titleLabel.snp.bottom).offset(20)
                }
            }
            
            previousItemView = itemView
        }
        
        let continueButton = createContinueButton()
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
    
    private func createItemView(item: Item) -> UIView {
        let itemView = UIView()
        
        let iconLabel = UILabel()
        iconLabel.text = item.icon
        iconLabel.backgroundColor = .blue
        iconLabel.layer.cornerRadius = 4
        iconLabel.clipsToBounds = true
        itemView.addSubview(iconLabel)
        
        let itemLabel = UILabel()
        itemLabel.text = item.label
        itemView.addSubview(itemLabel)
        
        iconLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        itemView.layer.cornerRadius = 4
        itemView.layer.borderWidth = 2
        itemView.layer.borderColor = UIColor.gray.cgColor
        
        return itemView
    }
    
    private func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 34
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
  
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}
