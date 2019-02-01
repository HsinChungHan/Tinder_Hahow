//
//  RegisterViewController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //UI Component
    lazy var selectPhotoButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16.0
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField.init(padding: 24, backgroundColor: .white)
        tf.placeholder = "Enter full name here"
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField.init(padding: 24, backgroundColor: .white)
        tf.placeholder = "Enter email here"
        tf.keyboardType = .emailAddress

        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField.init(padding: 24, backgroundColor: .white)
        tf.placeholder = "Enter password here"
        tf.isSecureTextEntry = true

        return tf
    }()
    
    
    
    lazy var registerButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8060349822, green: 0.03426375985, blue: 0.3326358795, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradienLayer()
        setupLayout()
    }
    
    fileprivate func setupGradienLayer(){
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9996470809, green: 0.3580417037, blue: 0.1868433356, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.9977402091, green: 0.03317080066, blue: 0.6062759757, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupLayout(){
        let stackView = UIStackView.init(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        view.addSubview(stackView)
        stackView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .zero)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
