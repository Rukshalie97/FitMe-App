//
//  SingleWorkoutViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-20.
//
import UIKit
import SnapKit
import Odeum

class SingleWorkoutViewController: UIViewController {
    
    var seletedWorkout : WorkoutModel?
    
    var selectedPersonalWorkOut : PersonalWorkoutsModel?
    
    let odeumPlayer = OdeumPlayerView()
    
    let workoutName : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    let workoutDescription : UITextView = {
        let textview = UITextView()
        
        return textview
    }()
    
    let workoutCategoryLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "Category"
        return label
    }()
    
    let catValue : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    
    let workoutRep : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "Rep Count"
        return label
    }()
    
    let repValue : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let workoutDuration : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "Duration"
        return label
    }()
    
    let durationValue : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let catStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 2
        return stack
    }()
    
    let repStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    let durationStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    let detailStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(odeumPlayer)
        view.addSubview(workoutName)
        
        catStack.addArrangedSubview(workoutCategoryLabel)
        catStack.addArrangedSubview(catValue)
        
        repStack.addArrangedSubview(workoutRep)
        repStack.addArrangedSubview(repValue)
       
        durationStack.addArrangedSubview(workoutDuration)
        durationStack.addArrangedSubview(durationValue)
        
        detailStack.addArrangedSubview(catStack)
        detailStack.addArrangedSubview(repStack)
        detailStack.addArrangedSubview(durationStack)
        
        view.addSubview(detailStack)
        
        view.addSubview(workoutDescription)
        
        setupContraint()
        
        setupViews()
        
        
    }
    
    func setupViews() {
        
        if let seletedWorkout = seletedWorkout {
            catValue.text = seletedWorkout.category.name
            durationValue.text = seletedWorkout.duration
            workoutDescription.text = seletedWorkout.description
            workoutName.text = seletedWorkout.name
            
            guard let videoURL = URL(string: "https://192-53-114-201.ip.linodeusercontent.com/videos/" + seletedWorkout.video) else { return }
            odeumPlayer.set(url: videoURL)
            
            odeumPlayer.backgroundColor = .white
            odeumPlayer.play()
        }else if let seletedWorkout = selectedPersonalWorkOut{
            catValue.text = seletedWorkout.goal
            durationValue.text = seletedWorkout.duration
            workoutDescription.text = seletedWorkout.description
            workoutName.text = seletedWorkout.name
            guard let videoURL = URL(string: "https://192-53-114-201.ip.linodeusercontent.com/videos/" + seletedWorkout.video) else { return }
            odeumPlayer.set(url: videoURL)
            odeumPlayer.backgroundColor = .white
            odeumPlayer.play()
        }
        
        
    }
    
    func setupContraint(){
        
        odeumPlayer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(320)
        }
        
        workoutName.snp.makeConstraints { make in
            make.top.equalTo(odeumPlayer.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        
        detailStack.snp.makeConstraints { make in
            make.top.equalTo(workoutName.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        workoutDescription.snp.makeConstraints { make in
            make.top.equalTo(detailStack.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
    }
}
