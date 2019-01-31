//
//  Advertiser.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/24.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit
struct Advertiser: ProducesCardViewModel {
    let title: String, brandName: String, posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel{
        let nameAtrributedString = NSAttributedString.init(string: title, attributes: [
            .font : UIFont.systemFont(ofSize: 32, weight: .heavy),
            .foregroundColor: UIColor.red
            ])
        let professionAtrributedString = NSAttributedString.init(string: "\n\(brandName)", attributes: [
            .font : UIFont.systemFont(ofSize: 18, weight: .heavy),
            .foregroundColor: UIColor.black
            ])
        let attributedText = NSMutableAttributedString.init()
        attributedText.append(nameAtrributedString)
        attributedText.append(professionAtrributedString)
        return CardViewModel.init(imageNames: [posterPhotoName], attributedText: attributedText, textAlignment: .center)
    }
}

