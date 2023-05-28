//
//  SelectGenderViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-13.
//

import UIKit
import SnapKit
import SPIndicator

class SelectGenderViewController: UIViewController {
    let titleLabel = UILabel()
    
    struct Item: Identifiable {
        var id = UUID().uuidString
        var icon: String
        var label: String
        var isSelected: Bool = false
    }
    
    let items: [Item] = [
        Item(icon: "🧔‍♂️", label: "Male"),
        Item(icon: "👩‍🦰", label: "Female"),
        Item(icon: "👨‍🎤", label: "Gender Nuetral"),
        
    ]
    
    var genderTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var userPef : UserPref?
    
    var selectedIndexes = [[IndexPath.init(row: 0, section: 0)], [IndexPath.init(row: 0, section: 1)]]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // setupViews()
        //setupConstraints()
        view.backgroundColor = .white
        
        titleLabel.text = "Select Gender"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        
        let continueButton = createContinueButton()
        
        view.addSubview(titleLabel)
        view.addSubview(genderTableView)
        view.addSubview(continueButton)
        
        genderTableView.register(SelectableCell.self, forCellReuseIdentifier: "genderCell")
        genderTableView.delegate = self
        genderTableView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        genderTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(continueButton.snp.top).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        continueButton.addTarget(self, action: #selector(continueFunction), for: .touchUpInside)
    }

    @objc func continueFunction(){
        let selectedIndex = selectedIndexes[0][0]
        userPef?.gender = selectedIndex.row
        let vc = SelectGoalViewController()
        vc.userPref = userPef
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    private func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 120/255, green: 80/255, blue: 191/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    

}

extension SelectGenderViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SelectableCell = tableView.dequeueReusableCell(withIdentifier: "genderCell", for: indexPath) as! SelectableCell
        cell.itemLabel.text = items[indexPath.row].label
        cell.iconLabel.text = items[indexPath.row].icon
        
        cell.selectionStyle = .none
        
        let selectedSectionIndexes = self.selectedIndexes[indexPath.section]
        if selectedSectionIndexes.contains(indexPath) {
            cell.checkbox.isSelected = true
        }
        else {
            cell.checkbox.isSelected = false
        }
        cell.runCheck()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell : SelectableCell = tableView.cellForRow(at: indexPath) as! SelectableCell

        if !self.selectedIndexes[indexPath.section].contains(indexPath) {
             
                //cell?.accessoryType = .checkmark
            cell.checkbox.isSelected = true
               self.selectedIndexes[indexPath.section].removeAll()

               self.selectedIndexes[indexPath.section].append(indexPath)
            cell.runCheck()
               tableView.reloadData()
           }
    }
}


