//
//  TopNavigationStackView.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/21.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let settingButton: UIButton = {
       let button = UIButton.init(type: .system)
        button.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let messageButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let fireImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "app_icon")
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        axis = .horizontal
        distribution = .equalCentering
        
        let subviews = [settingButton, fireImageView, messageButton]
        subviews.forEach { (view) in
            addArrangedSubview(view)
        }
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
//        let subviews = [#imageLiteral(resourceName: "top_left_profile"), #imageLiteral(resourceName: "app_icon"), #imageLiteral(resourceName: "top_right_messages")].map { (image) -> UIButton in
//            let button = UIButton.init(type: .system)
//            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
//            return button
//        }
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
