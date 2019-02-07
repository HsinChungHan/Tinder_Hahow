//
//  User.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/23.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit
extension Dictionary{
    func toString(key: Key) -> String{
        return self[key] as? String ?? ""
    }
    
    func toInt(key: Key) -> Int{
        return self[key] as? Int ?? 0
    }
}


struct User: ProducesCardViewModel {
    let name: String
    var age: Int?, profession: String?
    let imageUrl1: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        //we'll initialize our users here
        self.name = dictionary.toString(key: "fullName")
        self.age = dictionary.toInt(key: "age")
        self.profession = dictionary.toString(key: "profession")
        self.imageUrl1 = dictionary.toString(key: "imageUrl1")
        self.uid = dictionary.toString(key: "uid")
    }
    
    
    func toCardViewModel() -> CardViewModel{
        let nameAtrributedString = NSAttributedString.init(string: name, attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        //N\\A -> N/A
        let ageString = age != 0 ? "\(age!)" : "N\\A"
        let ageAtrributedString = NSAttributedString.init(string: " \(ageString)", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .regular)])
        
        let professionString = profession != "" ? "\(profession!)" : "Not available"
        let professionAtrributedString = NSAttributedString.init(string: "\n\(professionString)", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .heavy)])
        let attributedText = NSMutableAttributedString.init()
        attributedText.append(nameAtrributedString)
        attributedText.append(ageAtrributedString)
        attributedText.append(professionAtrributedString)
        return CardViewModel.init(imageNames: [imageUrl1], attributedText: attributedText, textAlignment: .left)
    }
}


