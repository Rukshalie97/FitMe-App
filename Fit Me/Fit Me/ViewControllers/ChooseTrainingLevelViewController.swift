//
//  ChooseTrainingLevelViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import Foundation
import UIKit
import SnapKit

class ChooseTrainingLevelViewController: UIViewController {
    let titleLabel = UILabel()
    var itemViews: [UIView] = []
    var selectedItemView: UIView?
    
    struct Item: Identifiable {
        var id = UUID().uuidString
        var heading: String
        var title: String
    }
    
    let items: [Item] = [Item(heading: "Beginner", title: "I want to start training"),
                         Item(heading: "Intermediate", title: "I want to continue my training"),
                         Item(heading: "Irregular Training", title: "I have been training on and off"),
                         Item(heading: "Medium", title: "I have been consistently training")]

    let continueButton = UIButton()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white

        titleLabel.text = "Choose Training Level"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        var previousItemView: UIView? = nil
        
        for item in items {
            let itemView = createItemView(item: item)
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemViewTapped(_:))))
            itemViews.append(itemView)
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
        
        createContinueButton()
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
    
    @objc private func itemViewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedItemView = sender.view else { return }

        // Reset the border color of the previously selected item view
        selectedItemView?.layer.borderColor = UIColor(red: 229/255, green: 233/255, blue: 239/255, alpha: 1.0).cgColor

        // Change the border color of the tapped item view
        tappedItemView.layer.borderColor = UIColor.purple.cgColor

        // Update the selected item view
        selectedItemView = tappedItemView
    }
    
    private func createItemView(item: Item) -> UIView {
        let itemView = UIView()
        
        let headingLabel = UILabel()
        headingLabel.text = item.heading
        headingLabel.font = UIFont.boldSystemFont(ofSize: 15)
        itemView.addSubview(headingLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = item.title
        itemView.addSubview(titleLabel)
        
        headingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headingLabel.snp.leading)
            make.top.equalTo(headingLabel.snp.bottom).offset(10)
        }
        
        itemView.layer.cornerRadius = 15
        itemView.layer.borderWidth = 0.5
        itemView.layer.borderColor = UIColor.gray.cgColor
        
        return itemView
    }
    
    private func createContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        continueButton.layer.cornerRadius = 10
    }
    
  
    // MARK: - Setup Constraints
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
}
