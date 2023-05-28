//
//  ChooseActivitiesViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//


import UIKit
import SnapKit
import SPIndicator

class ChooseActivitiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let titleLabel = UILabel()
    var selectedItems: [IndexPath] = []
    
    struct Item: Identifiable {
        var id = UUID().uuidString
        var emoji: String
        var activity: String
    }
    
    let items: [Item] = [Item(emoji: "🏃‍♂️", activity: "Cardio"),
                         Item(emoji: "💪", activity: "Power Training"),
                         Item(emoji: "🧘‍♀️", activity: "Yoga"),
                         Item(emoji: "🔥", activity: "Fat Burning"),
                         Item(emoji: "💃", activity: "Dancing"),
                         Item(emoji: "💪", activity: "Arms"),
                         Item(emoji: "💪", activity: "Abs"),
                         Item(emoji: "💪", activity: "Chest"),
                         Item(emoji: "💪", activity: "Back")]
    
    var selectedItem : Item?
    
    let continueButton = UIButton()
    var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Choose Activities"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
        
        createContinueButton()
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        continueButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
    }
    
    @objc func continueFunction(){
        if selectedItems.count > 0{
            self.navigationController?.pushViewController(CreatePlanViewController(), animated: true)
        }else{
            SPIndicator.present(title: "Please Select Activities to Continue", preset : .error, haptic: .warning)
        }
       
    }
    
    // MARK: - Collection View Delegate & DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.identifier, for: indexPath) as! ActivityCollectionViewCell
        let item = items[indexPath.row]
        cell.emojiLabel.text = item.emoji
        cell.activityLabel.text = item.activity
        cell.checkbox.isSelected = selectedItems.contains(indexPath)
        cell.contentView.layer.borderWidth = 0.5
        cell.contentView.layer.cornerRadius = 15
        
        if selectedItems.contains(indexPath) {
            cell.contentView.layer.borderColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0).cgColor
        } else {
            cell.contentView.layer.borderColor = UIColor(red: 229/255, green: 233/255, blue: 239/255, alpha: 1.0).cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//                if let cell = collectionView.cellForItem(at: indexPath) as? ActivityCollectionViewCell {
//
//                    if selectedItems.contains(indexPath) {
//                        // Deselect item
//                        selectedItems.removeAll(where: { $0 == indexPath })
//                    } else {
//                        // Select item
//                        selectedItems.append(indexPath)
//                    }
//                  //  cell.checkbox.isSelected = selectedItems.contains(indexPath)
//                    collectionView.reloadItems(at: [indexPath])
//                }
        
        
        
    }
    
    // MARK: - Setup Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // MARK: - Continue Button
    private func createContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        continueButton.layer.cornerRadius = 10
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
