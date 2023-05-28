//
//  SelectBirthdayViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-15.
//

import UIKit
import SnapKit
import SPIndicator

class SelectBirthdayViewController: UIViewController {
    
    let titleLabel = UILabel()
    let datePicker = UIDatePicker()
    let continueButton = UIButton(type: .system)
    
    var userPref : UserPref?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Select Birthday"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date() // restricts to past dates only
        view.addSubview(datePicker)
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1)
        continueButton.layer.cornerRadius = 10
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
    }
    
    @objc func continueFunction(){
        let selectedDate = datePicker.date
        
        // Calculate the date 14 years ago
        let calendar = Calendar.current
        let currentDate = Date()
        let fourteenYearsAgo = calendar.date(byAdding: .year, value: -14, to: currentDate)!
        
        
        
        if selectedDate > fourteenYearsAgo {
            SPIndicator.present(title: "Selected date is not higher than 14 years", preset: .error, haptic: .error)
            
        } else {
            
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate, to: currentDate)
            var age : Int = 0
            if let years = ageComponents.year {
                age = years
            }
            
            userPref?.birthday = datePicker.date
            userPref?.age = age
            let vc = SelectHeightViewController()
            vc.userPref = userPref
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
}
