//
//  OnBoardingViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-20.
//
//

import Foundation
import UIKit
import SnapKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let pageTexts = ["Welcome to our app!", "Find great features here!", "Start exploring now!"]
    let images = ["1.png", "2.png", "3.png"]
    var pageControl = UIPageControl()
    
    
    lazy var pages: [OnboardingPageViewController] = {
        var pages = [OnboardingPageViewController]()
        for i in 0..<pageTexts.count {
            let page = OnboardingPageViewController()
            page.pageIndex = i
            page.labelText = pageTexts[i]
            page.images = UIImage(named: images[i])
            pages.append(page)
        }
        return pages
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = pageTexts.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentPageIndex = (viewController as! OnboardingPageViewController).pageIndex
        if currentPageIndex == 0 {
            return nil
        }
        return pages[currentPageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentPageIndex = (viewController as! OnboardingPageViewController).pageIndex
        if currentPageIndex == pages.count - 1 {
            return nil
        }
        return pages[currentPageIndex + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return pageTexts.count
        }

        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            return 0
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            let pageContentViewController = pageViewController.viewControllers![0]
            self.pageControl.currentPage = (pageContentViewController as! OnboardingPageViewController).pageIndex
        }
}

class OnboardingPageViewController: UIViewController {
    
    var label: UILabel!
    
    var pageIndex: Int = 0
    var labelText: String = "" {
        didSet {
            if isViewLoaded {
                label.text = labelText
            }
        }
    }
    
    var imageView : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    var images : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(imageView)
        
        guard let image = images else { return }
        imageView.image = image
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            
        }
        
    }
}

