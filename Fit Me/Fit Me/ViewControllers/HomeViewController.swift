//
//  HomeViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//
import UIKit
import SnapKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    var tableView: UITableView!
    
    let categories = [Categories(name: "Yoga", image: "🧘🏽"), Categories(name: "Cardio", image: "🏃🏽‍♂️"), Categories(name: "Stretch", image: "🤸🏽"), Categories(name: "Weight Loss", image: "🏋🏽")]
    
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    let workoutLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    var categoryJSON : [CategoryModel] = []
    var personalWorkoutsJSON : [PersonalWorkoutsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addComponents()
        
        addContraint()
        
        configDataItems()
        
        loadCategories()
        
        loadPersonalWorkouts()
    }
    

    func addComponents(){
        
        view.addSubview(welcomeLabel)
        view.addSubview(categoryLabel)
        view.addSubview(workoutLabel)
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
        
        
    }
    
    func addContraint(){
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(60)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp_bottomMargin).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(130)
            make.top.equalTo(categoryLabel.snp_bottomMargin).offset(20)
        }
        
        workoutLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(workoutLabel.snp_bottomMargin).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
        }
        
    }
    
    func configDataItems(){
        welcomeLabel.text = "Welcome to FitMe!"
        categoryLabel.text = "Category"
        workoutLabel.text = "Workout Plan fits for You"
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func loadCategories(){
        NetworkManager.shared.fetchJSONData(urlString: APIManager.getCategories , from: self.view, decodingType: [CategoryModel].self) { (result: Result<[CategoryModel], Error>) in
            switch result {
            case .success(let cat):
                self.categoryJSON = cat
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
               
            case .failure(let error):
                print("Network or parsing error: \(error.localizedDescription)")
            }
        }
    }
    
    func loadPersonalWorkouts(){
        NetworkManager.shared.fetchJSONData(urlString: APIManager.getPersonalWorkouts , from: self.view, decodingType: [PersonalWorkoutsModel].self) { (result: Result<[PersonalWorkoutsModel], Error>) in
            switch result {
            case .success(let cat):
                self.personalWorkoutsJSON = cat
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               
            case .failure(let error):
                print("Network or parsing error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryJSON.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCell
        cell.iconLabel.text = categoryJSON[indexPath.row].icon
        cell.titleLabel.text = categoryJSON[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("workout")
        let vc = WorkoutsForCategoryViewControllers()
        vc.selectedCatName = categoryJSON[indexPath.row].name
        vc.selectedCatogory = categoryJSON[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalWorkoutsJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableCell
        let imageName = personalWorkoutsJSON[indexPath.row].image
        
        if let url = URL(string: APIManager.imageBase + imageName){
            cell.iconImageView.kf.setImage(with: url)
        }
        cell.titleLabel.text = personalWorkoutsJSON[indexPath.row].name
        cell.subtitleLabel.text = personalWorkoutsJSON[indexPath.row].duration
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SingleWorkoutViewController()
        vc.selectedPersonalWorkOut = personalWorkoutsJSON[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


class CategoryCell: UICollectionViewCell {
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let bgImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "cat-bg")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImage)
        bgImage.addSubview(titleLabel)
        bgImage.addSubview(iconLabel)
        
        bgImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(4)
            make.trailing.bottom.equalToSuperview().offset(-4)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(20)
        }
        
        iconLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalTo(titleLabel.snp_topMargin)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeTableCell: UITableViewCell {
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "exe-placeholder")
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "ex-bg")
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(hexString: "#7850BF")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bgImageView)
        
        self.selectionStyle = .none
        
        bgImageView.addSubview(iconImageView)
        bgImageView.addSubview(titleLabel)
        bgImageView.addSubview(subtitleLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            //make.top.equalTo(iconImageView)
            make.centerY.equalTo(bgImageView.snp.centerY).offset(-12)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//data model
struct Categories {
    var name : String
    var image : String
}

struct CategoryModel: Codable {
    let id, name, icon, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, icon, createdAt, updatedAt
    }
}

