//
//  CardViewModel.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/1/24.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

//View model get the presented data from model
//View model should represent the state of the view

class CardViewModel {
    //define some properties wd are gonna display or rander on the card view
    
    let imageNames: [String], attributedText: NSAttributedString, textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedText: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedText = attributedText
        self.textAlignment = textAlignment
    }
    var imageIndex: Int = 0{
        didSet{
            let image = UIImage.init(named: imageNames[imageIndex])
            imageIndexObserver?(image, imageIndex)
        }
    }
    
    //reactive programming
    var imageIndexObserver: ((_ image: UIImage?, _ imageIndex: Int) -> ())?
    
    
    func advanceToNextPhoto(){
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func backToPreviousPhoto(){
        imageIndex = max(0, imageIndex - 1)
    }
}

//What we can do from this viewmodel
