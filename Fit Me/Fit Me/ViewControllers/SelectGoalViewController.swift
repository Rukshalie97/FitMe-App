//
//  SelectGoalViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-14.
//
import UIKit
import SnapKit

import UIKit
import SnapKit

class SelectGoalViewController: UIViewController {
    let titleLabel = UILabel()
    
    struct Item: Identifiable {
        var id = UUID().uuidString
        var icon: String
        var label: String
        var isSelected: Bool = false
    }
    
    let items: [Item] = [
        Item(icon: "🌿", label: "Keep Fit"),
        Item(icon: "🏋🏽", label: "Build Muscle Mass"),
        Item(icon: "💪🏽", label: "Get Strong"),
        Item(icon: "👟", label: "Lose Weight")
    ]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
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
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    private func createItemView(item: Item) -> UIView {
        let itemView = UIView()
        
        let iconLabel = UILabel()
        iconLabel.text = item.icon
        iconLabel.font = UIFont.systemFont(ofSize: 30)
        iconLabel.textAlignment = .center
        iconLabel.backgroundColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 0.33)
        iconLabel.layer.cornerRadius = 28
        iconLabel.layer.masksToBounds = true
        itemView.addSubview(iconLabel)
        
        let itemLabel = UILabel()
        itemLabel.text = item.label
        itemLabel.font = UIFont.systemFont(ofSize: 18)
        itemLabel.textColor = .black
        itemView.addSubview(itemLabel)
        
        let checkbox = UIButton()
        checkbox.setImage(UIImage(systemName: "circle"), for: .normal)
        checkbox.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        checkbox.tintColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 1)
        checkbox.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        itemView.addSubview(checkbox)
        
        iconLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        checkbox.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        itemView.layer.cornerRadius = 15
        itemView.layer.borderWidth = 0.5
        itemView.layer.masksToBounds = true
        
        // Set initial border color to gray
        itemView.layer.borderColor = UIColor.gray.cgColor
        
        // Set initial selection state
        checkbox.isSelected = item.isSelected
        updateItemView(itemView, isSelected: item.isSelected)
        
        return itemView
    }
    
    private func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        button.layer.cornerRadius = 10
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
    
    // MARK: - Checkbox Action
    @objc private func checkboxTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let itemView = sender.superview {
            updateItemView(itemView, isSelected: sender.isSelected)
        }
    }
    
    // MARK: - Update Item View
    private func updateItemView(_ itemView: UIView, isSelected: Bool) {
        itemView.layer.borderColor = isSelected ? UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0).cgColor : UIColor.gray.cgColor
    }
}
