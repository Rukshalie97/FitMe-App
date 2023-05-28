//
//  SelectHeightViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-15.
//

import UIKit
import SnapKit

class SelectHeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    private let titleLabel = UILabel()
    private let continueButton = UIButton()
    private let weightTextField = UITextField()
    private let unitSegmentedControl = UISegmentedControl(items: ["Feets", "CM"])
    private let weightPickerView = UIPickerView()

    
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
        continueButton.backgroundColor = UIColor(hexString: "#7850BF")
        continueButton.layer.cornerRadius = 24
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
    }
    
    @objc func continueFunction(){
        self.navigationController?.pushViewController(SelectWeightViewController(), animated: true)
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
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.equalTo(200)
            make.height.equalTo(48)
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
        return unitSegmentedControl.selectedSegmentIndex == 0 ? 1000 : 500
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) lbs" : "\(row + 1) kg"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) lbs" : "\(row + 1) kg"
        weightTextField.text = selectedValue
    }


    @objc private func continueButtonTapped() {
       
    }
}
