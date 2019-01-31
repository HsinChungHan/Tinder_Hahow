//
//  User.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/23.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit
struct User: ProducesCardViewModel {
    
    let name: String, age: Int, profession: String, imageNames: [String]
    func toCardViewModel() -> CardViewModel{
        let nameAtrributedString = NSAttributedString.init(string: name, attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        let ageAtrributedString = NSAttributedString.init(string: " \(age)", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .regular)])
        let professionAtrributedString = NSAttributedString.init(string: "\n\(profession)", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .heavy)])
        let attributedText = NSMutableAttributedString.init()
        attributedText.append(nameAtrributedString)
        attributedText.append(ageAtrributedString)
        attributedText.append(professionAtrributedString)
        return CardViewModel.init(imageNames: imageNames, attributedText: attributedText, textAlignment: .left)
    }
}


