//
//  SelectGoalWeightViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-16.
//

import UIKit
import SnapKit

    class SelectGoalWeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

        let titleLabel = UILabel()
        let continueButton = UIButton()
        let weightTextField = UITextField()
        let unitSegmentedControl = UISegmentedControl(items: ["Pounds", "Kg"])
        let weightPickerView = UIPickerView()

        var userPref : UserPref?
        
        var selectedUnit: WeightUnit = .kilograms
        var selectedValue: Int = 1
       
        let poundsData: [Int] = Array(1...300)
        let kgData: [Int] = Array(1...150)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupConstraints()
        }

        
        private func setupViews() {
            view.backgroundColor = .white

            titleLabel.text = "Select Weight Goal"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
            titleLabel.textColor = .black
            view.addSubview(titleLabel)
            
                


            unitSegmentedControl.selectedSegmentIndex = 1
            view.addSubview(unitSegmentedControl)
            unitSegmentedControl.addTarget(self, action: #selector(unitSegmentedControlValueChanged), for: .valueChanged)
            
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
            
            userPref?.weightGoal = selectedValue
            userPref?.weightGoalUnit = selectedUnit
            let vc = ChooseTrainingLevelViewController()
            vc.userPref = userPref
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        @objc private func unitSegmentedControlValueChanged() {
            if unitSegmentedControl.selectedSegmentIndex == 0 {
                selectedUnit = .pounds
            } else {
                selectedUnit = .kilograms
            }
            
            weightPickerView.reloadAllComponents()
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
                make.top.equalTo(unitSegmentedControl.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.height.equalTo(60)
            }


            weightPickerView.snp.makeConstraints { make in
                make.top.equalTo(weightTextField.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.8)
                make.height.equalTo(150)
            }
            
            

            continueButton.layer.cornerRadius = 5
            continueButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                make.centerX.equalToSuperview()
                make.width.equalTo(UIScreen.main.bounds.size.width - 40)
                make.height.equalTo(50)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
                make.centerX.equalToSuperview()
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
            if selectedUnit == .kilograms {
                return kgData.count
            } else {
                return poundsData.count
            }
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if selectedUnit == .kilograms {
                return "\(kgData[row]) kg"
            } else {
                return "\(poundsData[row]) lbs"
            }
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           // var selectedValue = unitSegmentedControl.selectedSegmentIndex == 0 ? "\(row + 1) lbs" : "\(row + 1) kg"
            //weightTextField.text = selectedValue
            
            if selectedUnit == .kilograms {
                selectedValue = kgData[row]
                weightTextField.text = "\(kgData[row]) kg"
            } else {
                selectedValue = poundsData[row]
                weightTextField.text = "\(poundsData[row]) lbs"
            }
        }


    }


 
