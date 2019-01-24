//
//  HomeViewController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/21.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK:- Properties
    let topStackView = TopNavigationStackView.init(frame: .zero)
    let cardDocksView = UIView()
    let bottomStackView = HomeButtonStackView.init(frame: .zero)
    
    let users = [
        User(name: "Katy", age: 18, profession: "Music DJ", imageName: "lady1"),
        User(name: "Annie", age: 26, profession: "Nurse", imageName: "lady2")
    ]
    
    let cardViewModels = [
        User(name: "Katy", age: 18, profession: "Music DJ", imageName: "lady1").toCardViewModel(),
        User(name: "Annie", age: 26, profession: "Nurse", imageName: "lady2").toCardViewModel()
    ]
    
    //MARK:- ViewController's lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    //MARK:- Fileprivate
    fileprivate func setupDummyCard() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.imageView.image = UIImage.init(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedText
            cardView.informationLabel.textAlignment = cardVM.textAlignment
            cardDocksView.addSubview(cardView)
            cardView.fillSuperView()
        }
        
        
        
        users.forEach { (user) in
            let cardView = CardView()
            cardDocksView.addSubview(cardView)
            cardView.fillSuperView()
            cardView.informationLabel.text = "\(user.name) \(user.age) \n\(user.profession)"
            cardView.imageView.image = UIImage.init(named: user.imageName)


            let nameAtrributedString = NSAttributedString.init(string: user.name, attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])

            let ageAtrributedString = NSAttributedString.init(string: " \(user.age)", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .regular)])

            let professionAtrributedString = NSAttributedString.init(string: "\n\(user.profession)", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .heavy)])


            let attributedText = NSMutableAttributedString.init()
            attributedText.append(nameAtrributedString)
            attributedText.append(ageAtrributedString)
            attributedText.append(professionAtrributedString)

            cardView.informationLabel.attributedText = attributedText
        }
        
    }
    
    fileprivate func setupLayout(){
        view.backgroundColor = .white
        
        let subViews = [topStackView, cardDocksView, bottomStackView]
        let overallStackView = UIStackView.init(arrangedSubviews: subViews)
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        overallStackView.bringSubviewToFront(cardDocksView)
        
        setupDummyCard()
    }
}



