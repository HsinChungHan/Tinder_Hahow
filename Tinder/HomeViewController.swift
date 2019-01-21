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
        
        let topStackView = UIView()
        topStackView.backgroundColor = .blue
        
        let middleView = UIView()
        middleView.backgroundColor = .red
        
        let bottomStackView = UIView()
        bottomStackView.backgroundColor = .purple
        
        let subViews = [topStackView, middleView, bottomStackView]
        
        let overallStackView = UIStackView.init(arrangedSubviews: subViews)
        overallStackView.axis = .vertical
        overallStackView.distribution = .fillEqually
        
        view.addSubview(overallStackView)
        overallStackView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
}
