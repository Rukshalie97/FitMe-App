//
//  WorkoutsForCategoryViewControllers.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//
import UIKit
import SnapKit
import Kingfisher

class WorkoutsForCategoryViewControllers: UIViewController {
    
    var tableView: UITableView!
    
    var selectedCatName : String = ""
    var selectedCatogory : CategoryModel?
    
    var workouts : [WorkoutModel] = []
    
    let workoutLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(workoutLabel)
        
        workoutLabel.text = selectedCatName
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        
        workoutLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(40)
        }
        
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(workoutLabel.snp_bottomMargin).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
            
            loadWorkoutsForCategory()
        }
    }
    
    func loadWorkoutsForCategory(){
        guard let cat = selectedCatogory else { return }
        
        NetworkManager.shared.fetchJSONData(urlString: APIManager.getWorkoutsByCategory + cat.id, from: self.view, decodingType: [WorkoutModel].self) { (result: Result<[WorkoutModel], Error>) in
            switch result {
            case .success(let workout):
                self.workouts = workout
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               
            case .failure(let error):
                print("Network or parsing error: \(error.localizedDescription)")
            }
        }
    }

    
}

extension WorkoutsForCategoryViewControllers : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableCell
        
        let imageName = workouts[indexPath.row].image
        
        if let url = URL(string: APIManager.imageBase + imageName){
            cell.iconImageView.kf.setImage(with: url)
        }
        cell.titleLabel.text = workouts[indexPath.row].name
        cell.subtitleLabel.text = workouts[indexPath.row].duration
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SingleWorkoutViewController()
        vc.seletedWorkout = workouts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
