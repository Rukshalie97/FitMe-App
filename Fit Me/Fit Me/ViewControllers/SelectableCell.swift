//
//  SelectableCell.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-28.
//

import Foundation
import UIKit

class SelectableCell : UITableViewCell {
    let iconLabel = UILabel()
    let itemLabel = UILabel()
    let checkbox = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(){
        iconLabel.font = UIFont.systemFont(ofSize: 30)
        iconLabel.textAlignment = .center
        iconLabel.backgroundColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 0.33)
        iconLabel.layer.cornerRadius = 28
        iconLabel.layer.masksToBounds = true
        
        itemLabel.font = UIFont.systemFont(ofSize: 18)
        itemLabel.textColor = .black
        
        checkbox.setImage(UIImage(systemName: "circle"), for: .normal)
        // checkbox.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        checkbox.tintColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 1)
       // checkbox.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        
        self.contentView.addSubview(iconLabel)
        self.contentView.addSubview(itemLabel)
        self.contentView.addSubview(checkbox)
        
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
        
    }
    
//    @objc private func checkboxButtonTapped() {
//        checkbox.isSelected = !checkbox.isSelected
//        let imageName = checkbox.isSelected ? "circle" : "checkmark.circle.fill"
//        checkbox.setImage(UIImage(systemName: imageName), for: .normal)
//    }
    
    func runCheck(){
        checkbox.isSelected = !checkbox.isSelected
        let imageName = checkbox.isSelected ? "circle" : "checkmark.circle.fill"
        checkbox.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    
}
