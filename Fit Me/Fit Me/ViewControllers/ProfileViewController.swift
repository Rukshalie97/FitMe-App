//
//  ProfileViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//

import UIKit
import SnapKit

class ProfileUIViewController: UIViewController {
    
    let headingLabel = UILabel()
    let profileImageView = UIImageView()
    let nameTextField = UITextField()
    let genderTextField = UITextField()
    let heightTextField = UITextField()
    let weightTextField = UITextField()
    let bmiLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTapGesture()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        headingLabel.text = "Account Information"
        headingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headingLabel.textColor = .black
        view.addSubview(headingLabel)
        
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 0
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.isUserInteractionEnabled = true
        view.addSubview(profileImageView)
        
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        
        genderTextField.placeholder = "Gender"
        genderTextField.borderStyle = .roundedRect
        view.addSubview(genderTextField)
        
        heightTextField.placeholder = "Height"
        heightTextField.borderStyle = .roundedRect
        heightTextField.keyboardType = .decimalPad
        view.addSubview(heightTextField)
        
        weightTextField.placeholder = "Weight"
        weightTextField.borderStyle = .roundedRect
        weightTextField.keyboardType = .decimalPad
        view.addSubview(weightTextField)
        
        bmiLabel.font = UIFont.systemFont(ofSize: 16)
        bmiLabel.textColor = .black
        bmiLabel.layer.borderWidth = 1
        bmiLabel.layer.borderColor = UIColor.purple.cgColor
        bmiLabel.textAlignment = .center
        view.addSubview(bmiLabel)
    }
    
    private func setupConstraints() {
        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(155)
            make.top.equalToSuperview().offset(106)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(genderTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        bmiLabel.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func profileImageTapped() {
        let alertController = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        
        let selectPhotoAction = UIAlertAction(title: "Select Photo", style: .default) { _ in
            // Handle select photo action
        }
        alertController.addAction(selectPhotoAction)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            // Handle take photo action
        }
        alertController.addAction(takePhotoAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func calculateBMI() -> Double? {
        guard let heightText = heightTextField.text, let height = Double(heightText),
              let weightText = weightTextField.text, let weight = Double(weightText) else {
            return nil
        }
        
        let heightInMeters = height / 100.0
        let bmi = weight / (heightInMeters * heightInMeters)
        return bmi
    }
    
    private func updateBMIValue() {
        guard let bmi = calculateBMI() else {
            bmiLabel.text = ""
            bmiLabel.textColor = .purple
            return
        }
        
        let formattedBMI = String(format: "%.2f", bmi)
        bmiLabel.text = "BMI: \(formattedBMI)"
    }
}
