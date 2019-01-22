//
//  CardView.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/22.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class CardView: UIView {

    fileprivate let imageView: UIImageView = {
       let iv = UIImageView.init(image: #imageLiteral(resourceName: "girl"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        addPanGesture()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded()
        default:
            ()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- fileprivate
    fileprivate func setupLayout() {
        layer.cornerRadius = 10.0
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperView()
    }
    
    fileprivate func addPanGesture() {
        let panGetsure = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(panGetsure)
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        transform = CGAffineTransform.init(translationX: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {[weak self] in
            self?.transform = .identity
        }) { (_) in
            
        }
    }
}
