//
//  SelectHeightViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-15.
//

import UIKit
import SnapKit

class SelectHeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let titleLabel = UILabel()
    let unitSegmentedControl = UISegmentedControl(items: ["cm", "feet"])
    let heightPicker = UIPickerView()
    let heightTextField = UITextField()
    let heightsInCm = (100...250).map { "\($0)" }  // Heights from 100cm to 250cm
    let heightsInFeet = (3...8).map { "\($0)" }  // Heights from 3 feet to 8 feet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Select Height"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        unitSegmentedControl.selectedSegmentIndex = 0
        unitSegmentedControl.addTarget(self, action: #selector(unitChanged(_:)), for: .valueChanged)
        view.addSubview(unitSegmentedControl)
        
        heightPicker.delegate = self
        heightPicker.dataSource = self
        view.addSubview(heightPicker)
        
        heightTextField.placeholder = "Enter height"
        heightTextField.delegate = self
        view.addSubview(heightTextField)
        
        let continueButton = createContinueButton()
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 40)
            make.height.equalTo(50)
        }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        unitSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        heightPicker.snp.makeConstraints { make in
            make.top.equalTo(unitSegmentedControl.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightPicker.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
    }
    
    private func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if unitSegmentedControl.selectedSegmentIndex == 0 {
            return heightsInCm.count
        } else {
            return heightsInFeet.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if unitSegmentedControl.selectedSegmentIndex == 0 {
           
            return heightsInCm[row]
        } else {
            return heightsInFeet[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if unitSegmentedControl.selectedSegmentIndex == 0 {
            heightTextField.text = heightsInCm[row]
        } else {
            heightTextField.text = heightsInFeet[row]
        }
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Dismiss the keyboard.
        return true
    }

    // MARK: - Actions

    @objc func unitChanged(_ sender: UISegmentedControl) {
        heightPicker.reloadAllComponents()  // Reload the picker view when the unit is changed.
        heightTextField.text = ""  // Clear the text field when the unit is changed.
    }
}
