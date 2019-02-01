//
//  CustomTextField.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//
import UIKit

class CustomTextField: UITextField{
    var padding: CGFloat
    
    init(padding: CGFloat, backgroundColor: UIColor) {
        self.padding = padding
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 25
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        //Adjust the text padding
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize.init(width: 0, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

