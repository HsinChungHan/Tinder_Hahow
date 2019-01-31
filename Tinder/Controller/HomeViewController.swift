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
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            Advertiser.init(title: "We wanna build Instagram!", brandName: "Hsin's App", posterPhotoName: "poster"),
            User(name: "Katy", age: 18, profession: "Music DJ", imageNames: ["lady1-a", "lady1-b", "lady1-c", "lady1-d"]),
            User(name: "Annie", age: 26, profession: "Nurse", imageNames: ["lady2-a", "lady2-b", "lady2-c", "lady2-d", "lady2-e"])
            
        ] as! [ProducesCardViewModel]
        let cardViewModels = producers.map({return $0.toCardViewModel()})
        return cardViewModels
    }()
    
    //MARK:- ViewController's lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    //MARK:- Fileprivate
    fileprivate func setupDummyCard() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.setupViewModel(cardViewModel: cardVM)
            cardDocksView.addSubview(cardView)
            cardView.fillSuperView()
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



