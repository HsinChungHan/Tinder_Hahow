//
//  Bindable.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/4.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation

class Bindable<T>{
    var value: T?{
        didSet{
            observer?(value)
        }
    }
    
    var observer: ((_ value: T?) -> ())?
    
    func bind(observer: @escaping (_ value: T?) -> ()){
        self.observer = observer
    }
}
