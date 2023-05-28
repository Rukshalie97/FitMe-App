//
//  SelectHeightViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-15.
//

import UIKit
import SnapKit
import SPIndicator

class SelectHeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    private let titleLabel = UILabel()
    private let continueButton = UIButton()
    private let weightTextField = UITextField()
    private let unitSegmentedControl = UISegmentedControl(items: ["Feets", "CM"])
    private let weightPickerView = UIPickerView()
    
    var userPref : UserPref?
    
    let feetData: [Int] = Array(1...10) // Feet values from 1 to 10
    let cmData: [Int] = Array(1...300) // Centimeter values from 1 to 300
    
    var selectedUnit: LengthUnit = .feet
    var selectedValue: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Select Height"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        unitSegmentedControl.selectedSegmentIndex = 0
        view.addSubview(unitSegmentedControl)
        
        weightTextField.borderStyle = .roundedRect
        weightTextField.textAlignment = .center
        weightTextField.keyboardType = .decimalPad
        weightTextField.delegate = self
        view.addSubview(weightTextField)
        
        weightPickerView.delegate = self
        weightPickerView.dataSource = self
        view.addSubview(weightPickerView)
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1)
        continueButton.layer.cornerRadius = 10
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
        unitSegmentedControl.addTarget(self, action: #selector(unitSegmentedControlValueChanged), for: .valueChanged)
        
       
        
    }
    
    @objc private func unitSegmentedControlValueChanged() {
        if unitSegmentedControl.selectedSegmentIndex == 0 {
            selectedUnit = .feet
        } else {
            selectedUnit = .centimeters
        }
        
        weightPickerView.reloadAllComponents()
    }
    
    @objc func continueFunction(){
        
        if selectedUnit == .feet && selectedValue >= 4 {
            userPref?.heightUnit = .feet
            userPref?.height = selectedValue
            let vc = SelectWeightViewController()
            vc.userPref = userPref
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if selectedUnit == .centimeters && selectedValue >= 100 {
            userPref?.heightUnit = .centimeters
            userPref?.height = selectedValue
            
            let vc = SelectWeightViewController()
            vc.userPref = userPref
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            SPIndicator.present(title: "Selected value is not higher than the threshold", preset: .error, haptic: .error)
            
        }
        
       
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        unitSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(69)
            make.right.equalToSuperview().offset(-69)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(unitSegmentedControl.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        weightPickerView.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(150)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return unitSegmentedControl.selectedSegmentIndex == 0 ? 8 : 300
        if selectedUnit == .feet {
            return feetData.count // Number of rows for feet
        } else {
            return cmData.count // Number of rows for centimeters
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if selectedUnit == .feet {
            return "\(feetData[row]) ft"
        } else {
            return "\(cmData[row]) cm"
        }
        
    
        //        return unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) ft" : "\(row + 1) cm"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        var selectedValue = unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) ft" : "\(row + 1) cm"
        //        weightTextField.text = selectedValue
        
        if selectedUnit == .feet {
            selectedValue = feetData[row]
            weightTextField.text = "\(feetData[row]) ft"
        } else {
            selectedValue = cmData[row]
            weightTextField.text = "\(cmData[row]) cm"
        }
    }
    
}

enum LengthUnit {
    case feet
    case centimeters
}
