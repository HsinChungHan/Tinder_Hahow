//
//  HomeViewController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/21.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeViewController: UIViewController {
    //MARK:- Properties
    let topStackView = TopNavigationStackView.init(frame: .zero)
    let cardDocksView = UIView()
    let bottomControlsStackView = HomeButtonStackView.init(frame: .zero)
    
    var cardViewModels = [CardViewModel]()
    
    //MARK:- ViewController's lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingButton.addTarget(self, action: #selector(handleSetting(sender:)), for: .touchUpInside)
        setupLayout()
        fetchUserFromFirestore()
        bottomControlsStackView.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
    }
    
    @objc func handleRefresh(sender: UIButton){
        fetchUserFromFirestore()
    }
    
    @objc func handleSetting(sender: UIButton){
        let registerVC = RegistrationViewController()
        present(registerVC, animated: true, completion: nil)
    }
    
    //MARK:- Fileprivate
    fileprivate func setupFirestoreUserCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.setupViewModel(cardViewModel: cardVM)
            cardDocksView.addSubview(cardView)
            cardView.fillSuperView()
        }
    }
    
    fileprivate func setupLayout(){
        view.backgroundColor = .white
        
        let subViews = [topStackView, cardDocksView, bottomControlsStackView]
        let overallStackView = UIStackView.init(arrangedSubviews: subViews)
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        overallStackView.bringSubviewToFront(cardDocksView)
        
        setupFirestoreUserCards()
    }
    
    
    var lastFetchedUser: User?
    
    fileprivate func fetchUserFromFirestore(){
        let hud = JGProgressHUD.init(style: .dark)
        hud.textLabel.text = "Fetching Users"
        hud.show(in: view)
        //I'm goona introduce pagination here tp page through 2 users at one time
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedUser?.uid ?? ""]).limit(to: 2)
        query.getDocuments {[unowned self] (snapshot, error) in
            hud.dismiss()
            if let error = error{
                print("Failed to fetch user from firestore: \(error.localizedDescription)")
                return
            }
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictonary = documentSnapshot.data()
                let user = User.init(dictionary: userDictonary)
                self.lastFetchedUser = user
                self.cardViewModels.append(user.toCardViewModel())
                self.setupFromUser(user: user)
            })
        }
    }
    
    fileprivate func setupFromUser(user: User){
        let cardView = CardView()
        cardView.setupViewModel(cardViewModel: user.toCardViewModel())
        cardDocksView.addSubview(cardView)
        //avoiding image flikering
        cardDocksView.sendSubviewToBack(cardView)
        cardView.fillSuperView()
    }
}



