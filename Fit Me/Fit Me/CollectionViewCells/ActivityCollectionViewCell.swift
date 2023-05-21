//
//  ActivityCollectionViewCell.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import UIKit
import SnapKit

class ActivityCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActivityCollectionViewCell"
    let emojiLabel = UILabel()
    let activityLabel = UILabel()
    let checkbox = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        emojiLabel.font = UIFont.systemFont(ofSize: 30)
        emojiLabel.textAlignment = .center
        emojiLabel.backgroundColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 0.33)
        emojiLabel.layer.cornerRadius = 28
        emojiLabel.layer.masksToBounds = true
        contentView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }

        activityLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(activityLabel)
        activityLabel.snp.makeConstraints { make in
            make.leading.equalTo(emojiLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }

        checkbox.setImage(UIImage(systemName: "circle"), for: .normal)
        checkbox.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        checkbox.tintColor = UIColor(red: 120/255, green: 108/255, blue: 255/255, alpha: 1)
        contentView.addSubview(checkbox)
        checkbox.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }

        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(red: 229/255, green: 233/255, blue: 239/255, alpha: 1.0).cgColor
    }
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.contentView.layer.borderColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0).cgColor
                self.checkbox.isSelected = true
            }
            else
            {
                self.contentView.layer.borderColor = UIColor(red: 229/255, green: 233/255, blue: 239/255, alpha: 1.0).cgColor
                self.checkbox.isSelected = false
            }
        }
    }
}
