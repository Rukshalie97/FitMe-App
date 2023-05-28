//
//  SignUpViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import UIKit

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
        self.navigationController?.pushViewController(SelectGenderViewController(), animated: true)
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
