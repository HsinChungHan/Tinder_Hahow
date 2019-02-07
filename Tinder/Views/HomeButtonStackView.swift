//
//  HomeButtonStackView.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/21.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class HomeButtonStackView: UIStackView {

    static func setupButton(image: UIImage) -> UIButton{
        let button = UIButton.init(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    let refreshButton = setupButton(image: #imageLiteral(resourceName: "refresh_circle"))
    let dislikeButton = setupButton(image: #imageLiteral(resourceName: "dismiss_circle"))
    let superlikeButton = setupButton(image: #imageLiteral(resourceName: "super_like_circle"))
    let likeButton = setupButton(image: #imageLiteral(resourceName: "like_circle"))
    let specialButton = setupButton(image: #imageLiteral(resourceName: "boost_circle"))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        axis = .horizontal
        distribution = .fillEqually
    
        [refreshButton, dislikeButton, superlikeButton, likeButton, specialButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
