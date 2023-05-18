//
//  CreatePlanViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-17.
//

import UIKit
import SnapKit

class CreatePlanViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add the activity indicator to the view
        view.addSubview(activityIndicator)
        
        // Apply constraints using SnapKit
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // Start animating the activity indicator
        activityIndicator.startAnimating()
    }
    
    // Call this method to stop the loader and remove the view
    func stopLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
