//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/2.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit

class RegistrationViewModel{
    var fullName: String?{
        didSet{
            checkFormValidity()
        }
    }
    
    var email: String?{
        didSet{
            checkFormValidity()
        }
    }
    
    var password: String?{
        didSet{
            checkFormValidity()
        }
    }
    
   
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
        
    }
    
    //reactive programming
    var isFormValidObserver: ((_ isFormValid: Bool) -> ())?
}
