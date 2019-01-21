//
//  HomeViewController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/21.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        let topSubviews = [UIColor.lightGray, .gray, .darkGray].map { (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            return view
        }
        let topStackView = UIStackView.init(arrangedSubviews: topSubviews)
        topStackView.distribution = .fillEqually
        topStackView.axis = .horizontal
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let middleView = UIView()
        middleView.backgroundColor = .red
        
        let bottomStackView = UIView()
        bottomStackView.backgroundColor = .yellow
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let subViews = [topStackView, middleView, bottomStackView]
        
        let overallStackView = UIStackView.init(arrangedSubviews: subViews)
        overallStackView.axis = .vertical
//        overallStackView.distribution = .fillEqually
        
        view.addSubview(overallStackView)
        overallStackView.fillSuperView()
    }
    
}



