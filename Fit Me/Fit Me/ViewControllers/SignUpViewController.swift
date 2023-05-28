//
//  SignUpViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import UIKit
import SPIndicator

class SignUpViewController: UIViewController {
    
    let stackView = UIStackView()
    let fullNameField = PaddedTextField()
    let emailField = PaddedTextField()
    let passwordField = PaddedTextField()
    let signUpButton = UIButton()
    
    let signInStackView = UIStackView()
    let signInLabel = UILabel()
    let signInButton = UIButton()
    
    let signUpLabel = UILabel()
    
    var userPref : UserPref = UserPref()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        configureTextField(textField: fullNameField, placeholder: "Full Name")
        configureTextField(textField: emailField, placeholder: "Email")
        configureTextField(textField: passwordField, placeholder: "Password", isSecure: true)
        
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor =  UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        signUpButton.layer.cornerRadius = 22
        
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.addArrangedSubview(fullNameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(signUpButton)
        
        
        view.addSubview(stackView)
        
        
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        signInLabel.text = "Already have an account?"
        
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.purple, for: .normal)
        
        
        signInStackView.axis = .horizontal
        signInStackView.distribution = .fill
        signInStackView.spacing = 10
        signInStackView.addArrangedSubview(signInLabel)
        signInStackView.addArrangedSubview(signInButton)
        
        view.addSubview(signInStackView)
        
        signInStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        signUpLabel.text = "Sign Up"
        signUpLabel.font = UIFont.systemFont(ofSize: 30)
        signUpLabel.textAlignment = .center
        
        view.addSubview(signUpLabel)
        
        
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        signUpButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
    }
    
    @objc func continueFunction(){
        if validateFields() {
            userPref.name = fullNameField.text
            userPref.email = emailField.text
            userPref.password = passwordField.text
            let vc = SelectGenderViewController()
            vc.userPef = userPref
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            SPIndicator.present(title: "Invalid Fileds data", preset: .error, haptic: .error)
        }

    }
    
    func validateFields() -> Bool {
        guard let fullName = fullNameField.text, !fullName.isEmpty else {
            // Full name is empty
            return false
        }
        
        guard let email = emailField.text, !email.isEmpty else {
            // Email is empty
            return false
        }
        
        guard isValidEmail(email) else {
            // Email is not valid
            return false
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            // Password is empty
            return false
        }
        
        // All fields are valid
        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    
    
    func configureTextField(textField: PaddedTextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.layer.cornerRadius = 22
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
