//
//  CreatePlanViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import UIKit
import SnapKit
import MKRingProgressView
import SwiftyJSON

class CreatePlanViewController: UIViewController {
    
    let ringProgressView = RingProgressView()
    
    var displayLink: CADisplayLink?
    var counter = 0
    
    var userPref : UserPref?
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    let completeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let infoLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let bg : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "gr-bg")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerUserPref()
        
        let continueButton = createContinueButton()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(ringProgressView)
        view.addSubview(bg)
        view.addSubview(completeLabel)
        view.addSubview(infoLabel)
        view.addSubview(continueButton)
        
        titleLabel.text = "We create your \ntraining plan"
        infoLabel.text = "We create a workout plan according \nto your preferances, \nfitness goal and level"
        
        ringProgressView.startColor = UIColor(hexString: "786CFF")
        ringProgressView.endColor = UIColor(hexString: "7850BF")
        ringProgressView.ringWidth = 25
        ringProgressView.progress = 0.0
        
        
        ringProgressView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(300)
        }
        
        UIView.animate(withDuration: 2) {
            self.ringProgressView.progress = 1.0
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        bg.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(ringProgressView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(continueButton.snp.top).offset(-10)
        }
        
        completeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateCounter))
        displayLink?.add(to: .main, forMode: .default)
        
       
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        continueButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
    }
    
    @objc func continueFunction(){
       // self.navigationController?.pushViewController((), animated: true)
        UserDefaults.standard.set(true, forKey: "isLogged")
        let rootVC = TabViewController()
        rootVC.userPref = userPref
       
        
        let homeVC = UINavigationController(rootViewController: rootVC)
       
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
    
    @objc func updateCounter() {
        if counter < 100 {
            counter += 1
            completeLabel.text = "\(counter) %"
            
            if counter == 100 {
                displayLink?.invalidate()
                displayLink = nil
            }
        }
    }
    
    private func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Start Training", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func registerUserPref(){
        let birthday = userPref?.birthday ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMMM-dd"
        let birthdayString = dateFormatter.string(from: birthday)
     
        let name = userPref?.name ?? ""
        let email = userPref?.email ?? ""
        let pass =  userPref?.password ?? ""
        
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
        
        let genderString = gender == 0 ? "Male" : "Female"
        let heightUnitString = heightUnit == .centimeters ? "cm" : "ft"
        let weightUnitString = weighUnit == .kilograms ? "kg" : "lbs"
        let weightGoalUnitString = weightGoalUnit == .kilograms ? "kg" : "lbs"
        
        let param = ["name" : name, "email" : email, "pass" : pass , "age" : String(age), "gender" : genderString, "birthday" : birthdayString, "goal" : String(goal) , "height" : String(height) + heightUnitString , "weight" : String(weight) + weightUnitString, "goal_weight" : String(weightGoal) + weightGoalUnitString ,"level" : "Beginner", "interest" : activity  ]
        
        NetworkManager.shared.sendJSONData(urlString: APIManager.saveuserPref, from: self.view, param: param) { result in
            switch result{
            case .success(let data):
                let response = JSON(data)
                print(response)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
}
