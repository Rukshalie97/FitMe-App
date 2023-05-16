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
    let continueButton = UIButton()
    let heightTextField = UITextField()
    let unitSegmentedControl = UISegmentedControl(items: ["Feet", "Cm"])
    let heightPickerView = UIPickerView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white

        titleLabel.text = "Select Height"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)

        unitSegmentedControl.selectedSegmentIndex = 0
        view.addSubview(unitSegmentedControl)

        heightTextField.borderStyle = .roundedRect
        heightTextField.textAlignment = .center
        heightTextField.keyboardType = .decimalPad
        heightTextField.delegate = self
        view.addSubview(heightTextField)

        heightPickerView.delegate = self
        heightPickerView.dataSource = self
        view.addSubview(heightPickerView)

        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(hexString: "#7850BF")
        continueButton.layer.cornerRadius = 5
        view.addSubview(continueButton)
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

        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(unitSegmentedControl.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }

        heightPickerView.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        continueButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(465)
            make.width.equalTo(359)
            make.height.equalTo(48)
        }
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - UIPickerViewDelegate and UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitSegmentedControl.selectedSegmentIndex == 0 ? 1000 : 500
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) ft" : "\(row + 1) cm"
    }
}

