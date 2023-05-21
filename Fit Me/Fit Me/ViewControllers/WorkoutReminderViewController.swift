//
//  WorkoutReminderViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//

import UIKit
import SnapKit

class WorkoutReminderViewController: UIViewController {
    
    let titleLabel = UILabel()
    let daysLabel = UILabel()
    let daysStackView = UIStackView()
    let timeLabel = UILabel()
    let timePicker = UIDatePicker()
    let createReminderButton = UIButton()
    
    var selectedDays: [String] = []
    var selectedTime: Date?
    
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Workout Reminder"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        daysLabel.text = "Select the days you want to exercise"
        daysLabel.font = UIFont.systemFont(ofSize: 18)
        daysLabel.textColor = .black
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(daysLabel)
        
        setupDaysStackView()
        
        timeLabel.text = "Select the times you want to exercise"
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.textColor = .black
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        timePicker.datePickerMode = .time
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker)
        
        createReminderButton.setTitle("Create Reminder", for: .normal)
        createReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        createReminderButton.setTitleColor(.white, for: .normal)
        createReminderButton.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        createReminderButton.layer.cornerRadius = 10.0
        createReminderButton.addTarget(self, action: #selector(createReminderButtonTapped), for: .touchUpInside)
        createReminderButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createReminderButton)
    }
    
    private func setupDaysStackView() {
        daysStackView.axis = .horizontal
        daysStackView.alignment = .fill
        daysStackView.distribution = .fillEqually
        daysStackView.spacing = 10
        daysStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(daysStackView)
        
        for (index, day) in daysOfWeek.enumerated() {
            let dayCircle = createDayCircle(withText: day, tag: index)
            daysStackView.addArrangedSubview(dayCircle)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dayCircleTapped(_:)))
            dayCircle.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func createDayCircle(withText text: String, tag: Int) -> UIView {
        let circleView = UIView()
        circleView.layer.cornerRadius = 20.0
        circleView.layer.borderWidth = 1.0
        circleView.layer.borderColor = UIColor.lightGray.cgColor
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        circleView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        circleView.tag = tag
        
        return circleView
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        daysLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        daysStackView.snp.makeConstraints { make in
            make.top.equalTo(daysLabel.snp.bottom).offset(200)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40.0)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(daysStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        createReminderButton.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    // MARK: - Button Actions
    @objc private func createReminderButtonTapped() {
        if selectedDays.isEmpty || selectedTime == nil {
            showAlert(withTitle: "Reminder Creation Failed", message: "Please select days and time for the reminder.")
            return
        }
        
        // Create reminder logic goes here
        
        showAlert(withTitle: "Reminder Created", message: "Your workout reminder has been set for \(selectedDays.joined(separator: ", ")) at \(formattedTime(from: selectedTime!)).")
    }
    
    @objc private func dayCircleTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let circleView = gestureRecognizer.view else { return }
        
        let selectedTag = circleView.tag
        
        if selectedDays.contains(daysOfWeek[selectedTag]) {
            // Remove the selected day
            selectedDays.removeAll { $0 == daysOfWeek[selectedTag] }
            circleView.backgroundColor = .clear
        } else {
            // Add the selected day
            selectedDays.append(daysOfWeek[selectedTag])
            circleView.backgroundColor = UIColor.purple
        }
    }
    
    // MARK: - Helper Methods
    private func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
