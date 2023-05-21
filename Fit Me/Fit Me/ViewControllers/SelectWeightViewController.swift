//
//  SelectWeightViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-15.
//

import UIKit
import SnapKit

class SelectWeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    let titleLabel = UILabel()
    let continueButton = UIButton()
    let weightTextField = UITextField()
    let unitSegmentedControl = UISegmentedControl(items: ["Pounds", "Kg"])
    let weightPickerView = UIPickerView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white

        titleLabel.text = "Select Weight"
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
        self.navigationController?.pushViewController(SelectGoalWeightViewController(), animated: true)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }

        unitSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(69)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-69)
        }

        

        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-400)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(132)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-132)
            make.width.equalTo(97)
            make.height.equalTo(64)
        }


        weightPickerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(450)
            make.centerX.equalToSuperview()
        }

        continueButton.layer.cornerRadius = 5
        continueButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(400)
            make.width.equalTo(359)
            make.height.equalTo(48)
        

           
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
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
        return unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) lbs" : "\(row + 1) kg"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) lbs" : "\(row + 1) kg"
        weightTextField.text = selectedValue
    }


}

extension UIColor {
    convenience init(hexString: String) {
        let scanner = Scanner(string: hexString)
        let prefixLen = hexString.hasPrefix("#") ? 1 : 0 // check if the hex color starts with #
        
        scanner.currentIndex = hexString.index(hexString.startIndex, offsetBy: prefixLen)
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
