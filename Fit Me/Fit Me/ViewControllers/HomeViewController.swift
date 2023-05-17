//
//  HomeViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    let welcomeLabel = UILabel()
    let searchBar = UISearchBar()
    var collectionView: UICollectionView!
    
    let categories = ["Cardio", "Yoga", "Stretch", "Gym"]
    let workouts = [("Rapid Lower Body", "Beginner", "42 min"), ("Bodyweight Stretch", "Beginner", "25 min")]
    let exercises = [("Front and Back Lunge", "0:30"), ("Side Plank", "0:30"), ("Arm circles", "0:30"), ("Sumo Squat", "0:30")]
    
    enum SectionLayoutKind: Int, CaseIterable {
        case category
        case workout
        case exercise
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        welcomeLabel.text = "Hi, Rukshalie"
        welcomeLabel.font = UIFont.systemFont(ofSize: 26)
        view.addSubview(welcomeLabel)
        
        searchBar.placeholder = "Search something"
        view.addSubview(searchBar)
        
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: WorkoutCell.identifier)
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        view.addSubview(collectionView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Create Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex)!
            
            switch sectionLayoutKind {
            case .category:
                // Horizontal list
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
                
            case .workout:
                // Vertical list
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
                
            case .exercise:
                // Grid
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
            }
        }
        return layout
    }
    
    // MARK: - Collection View Delegate & Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categories.count
        case 1:
            return workouts.count
        case 2:
            return exercises.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.titleLabel.text = categories[indexPath.item]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCell.identifier, for: indexPath) as! WorkoutCell
            let workout = workouts[indexPath.item]
            cell.titleLabel.text = workout.0
            cell.subTitleLabel.text = workout.1
            cell.timeLabel.text = workout.2
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
            let exercise = exercises[indexPath.item]
            cell.titleLabel.text = exercise.0
            cell.timeLabel.text = exercise.1
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
