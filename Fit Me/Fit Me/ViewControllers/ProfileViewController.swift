//
//  ProfileViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let headingLabel = UILabel()
    let profileImageView = UIImageView()
    let nameTextField = UITextField()
    let genderTextField = UITextField()
    let heightTextField = UITextField()
    let weightTextField = UITextField()
    let bmiLabel = UILabel()
    
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    
    var userPref : UserPref?
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameMailStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("User Pref in profile \(userPref)")
        
        titleLabel.text = "Profile"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        view.addSubview(nameMailStack)
        
        nameLabel.text = "Name"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameMailStack.addArrangedSubview(nameLabel)
        
        emailLabel.text = "Email"
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.textColor = .black
        emailLabel.textAlignment = .center
        nameMailStack.addArrangedSubview(emailLabel)
        
        
        view.addSubview(verticalStackView)
        
        view.addSubview(logoutButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        nameMailStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(nameMailStack.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        let birthday = userPref?.birthday ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMMM-dd"
        let birthdayString = dateFormatter.string(from: birthday)
        
     
        let age = userPref?.age ?? 00
        let height = userPref?.height ?? 00
        let heightUnit = userPref?.heightUnit ?? .centimeters
        let weight = userPref?.weight ?? 0.0
        let weighUnit = userPref?.weightUnit ?? .kilograms
        let weightGoal = userPref?.weightGoal ?? 0
        let weightGoalUnit = userPref?.weightGoalUnit ?? .kilograms
        let gender = userPref?.gender ?? 1
        let goal : Int = userPref?.goal ?? 0
        let activity = userPref?.activity ?? "Yoga"
        
        let name = userPref?.name ?? ""
        let email = userPref?.email ?? ""
        
        nameLabel.text = name
        emailLabel.text = email
        
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Birthday", valueText: "\(birthdayString)"))
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Age", valueText: "\(age)"))
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Height", valueText: "\(height) \(heightUnit == .centimeters ? "cm" : "ft")"))
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Weight", valueText: "\(weight) \(weighUnit == .kilograms ? "kg" : "lbs")"))
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Weight Goal", valueText:"\(weightGoal) \(weightGoalUnit == .kilograms ? "kg" : "lbs")"))
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Gender", valueText: "\(gender == 1 ? "Male" : "Female")"))
        verticalStackView.addArrangedSubview(createHorizontalStackView(labelText: "Activity", valueText: "\(activity)"))
        
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            // Perform logout action here
            self.performLogout()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func performLogout() {
        UserDefaults.standard.set(false, forKey: "isLogged")
        let vc =  UINavigationController(rootViewController: StartViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func createHorizontalStackView(labelText: String, valueText: String) -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = labelText
        
        let valueLabel = UILabel()
        valueLabel.textColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        valueLabel.text = valueText
        
        horizontalStackView.addArrangedSubview(label)
        horizontalStackView.addArrangedSubview(valueLabel)
        
        return horizontalStackView
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
