//
//  CardView.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/22.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class CardView: UIView {
    fileprivate var cardViewModel: CardViewModel!{
        didSet{
            imageView.image = UIImage.init(named: cardViewModel.imageName)
            informationLabel.attributedText = cardViewModel.attributedText
            informationLabel.textAlignment = cardViewModel.textAlignment
        }
    }
    
    fileprivate let gradientLayer = CAGradientLayer()

    
    public func setupViewModel(cardViewModel: CardViewModel){
        self.cardViewModel = cardViewModel
    }
    
    //MARK:- Configuration
    fileprivate let threhold: CGFloat = 80
    
    fileprivate let imageView: UIImageView = {
       let iv = UIImageView.init(image: #imageLiteral(resourceName: "lady1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate let informationLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        lb.text = "TEST NAME TEST AGE \nTEST PROFESSION"
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        addPanGesture()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
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
        
        //add CAGRaident layer into view's sublayer
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        self.layer.addSublayer(gradientLayer)
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .zero)
    }
    
    override func layoutSubviews() {
        //In here you can get cardView's frame
        gradientLayer.frame = frame
    }
    
    fileprivate func addPanGesture() {
        let panGetsure = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(panGetsure)
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        //how to convert degrees into radians
        let degrees: CGFloat = translation.x / 20
        let angle: CGFloat = degrees * .pi / 180
        let rotationTransformation = CGAffineTransform.init(rotationAngle: angle)
        transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismiss = abs(gesture.translation(in: nil).x) > threhold
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {[weak self] in
            if shouldDismiss{
                self?.frame = CGRect.init(x: 600 * translationDirection, y: 0, width: (self?.frame.width)!, height: (self?.frame.height)!)
            }else{
                self?.transform = .identity
            }
        }) { [weak self] (_) in
            self?.transform = .identity
            if shouldDismiss{
                self?.removeFromSuperview()
            }
        }
    }
}
