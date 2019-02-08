//
//  SettingCell.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/8.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    class SettingTextField: UITextField {
        override var intrinsicContentSize: CGSize{
            return .init(width: 0, height: 44)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
    }
    
    
    let textField: SettingTextField = {
        let tf = SettingTextField()
        tf.placeholder = "Enter Name"
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        addSubview(textField)
        textField.fillSuperView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
