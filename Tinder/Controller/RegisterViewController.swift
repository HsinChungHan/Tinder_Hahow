//
//  RegisterViewController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //Mark:- UI Component
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
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField.init(padding: 24, backgroundColor: .white)
        tf.placeholder = "Enter email here"
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField.init(padding: 24, backgroundColor: .white)
        tf.placeholder = "Enter password here"
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextChange(textField: UITextField){
        if textField == fullNameTextField{
            registrationViewModel.fullName = textField.text
        }else if textField == emailTextField{
            registrationViewModel.email = textField.text
        }else{
            registrationViewModel.password = textField.text
        }
    }
    
    
    
    lazy var registerButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = #colorLiteral(red: 0.8060349822, green: 0.03426375985, blue: 0.3326358795, alpha: 1)
        button.isEnabled = false
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 25.0
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView.init(arrangedSubviews:
            [fullNameTextField,
             emailTextField,
             passwordTextField,
             registerButton
            ])
        sv.axis = .vertical
        sv.spacing = 8.0
        sv.distribution = .fillEqually
        return sv
    }()
    
    
    lazy var overallStackView = UIStackView.init(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
        ]
    )
    
    let gradientLayer = CAGradientLayer()
    
    let registrationViewModel = RegistrationViewModel()
    //MARK:- ViewController function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObserver()
        setupTapGesture()
        setupGradientLayer()
        setupLayout()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass == .compact{
            //when the device is landscape...
            overallStackView.axis = .horizontal
        }else{
            //when the device is portrait...
            overallStackView.axis = .vertical
        }
    }
    
    //MARK:- Private
    
    fileprivate func setupRegistrationViewModelObserver(){
        registrationViewModel.isFormValidObserver = {[unowned self](isFormValid) in
            self.registerButton.isEnabled = isFormValid
            if isFormValid{
                self.registerButton.setTitleColor(.white, for: .normal)
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8060349822, green: 0.03426375985, blue: 0.3326358795, alpha: 1)
            }else{
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .disabled)
            }
        }
    }
    
    fileprivate func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handelKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardWillShow(notification: Notification){
//        print("Keyboard will show...")
        print(notification.userInfo)
        //Try to find keyboard's height
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        
        print(keyboardFrame)
        
        //Try to figure out how tall the gap between register button and view bottom
        let bottomSpace = view.frame.height - overallStackView.frame.maxY
        print(view.frame.height - overallStackView.frame.maxY)
        print(view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height)
        
        let space: CGFloat = 10
        let viewOffsetY = keyboardFrame.height - bottomSpace + space
        UIView.animate(withDuration: 1.0) {[weak self] in
            self?.view.transform = CGAffineTransform.init(translationX: 0, y: -viewOffsetY)
        }
    }
    
    @objc func handelKeyboardWillHide(){
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            self?.view.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    fileprivate func setupGradientLayer(){
        let topColor = #colorLiteral(red: 0.9996470809, green: 0.3580417037, blue: 0.1868433356, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.9977402091, green: 0.03317080066, blue: 0.6062759757, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    
    
    fileprivate func setupLayout(){
//        stackView.axis = .vertical
        overallStackView.axis = .vertical
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overallStackView.spacing = 8.0
        view.addSubview(overallStackView)
        overallStackView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .zero)
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    fileprivate func setupTapGesture(){
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleTapDismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapDismissKeyboard(){
//        resignFirstResponder()
        view.endEditing(true)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {[weak self] in
            self?.view.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
}
