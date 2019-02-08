//
//  SettingController.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/8.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class CustomImagePickerController: UIImagePickerController {
    var imageButton: UIButton?
}


class SettingController: UITableViewController {

    func createButton(selector: Selector) -> UIButton{
        let button = UIButton.init(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8.0
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    lazy var image1Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image2Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image3Button = createButton(selector: #selector(handleSelectPhoto))
    
    @objc fileprivate func handleSelectPhoto(button: UIButton){
        let imagePickerController = CustomImagePickerController()
        imagePickerController.imageButton = button
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItens()
        setupTableViewLayout()
    }
    
    //MARK:- UITableView Controller life function
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.addSubview(image1Button)
        
        let image1Padding = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 0)
        image1Button.anchor(top: headerView.topAnchor, bottom: headerView.bottomAnchor, leading: headerView.leadingAnchor, trailing: nil, padding: image1Padding, size: .zero)
        image1Button.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.45).isActive = true
        
        let stackView = UIStackView.init(arrangedSubviews: [image2Button, image3Button])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        headerView.addSubview(stackView)
        let stackViewPadding = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.anchor(top: headerView.topAnchor, bottom: headerView.bottomAnchor, leading: image1Button.trailingAnchor, trailing: headerView.trailingAnchor, padding: stackViewPadding, size: .zero)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    //MARK: - Private
    fileprivate func setupNavigationItens() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: #selector(handleDismiss)),
            UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(handleDismiss))
        ]
    }
    
    @objc fileprivate func handleDismiss(sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupTableViewLayout() {
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
    }
}


extension SettingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        //how do I set image on my particular button when I select photo
        let imageButton = (picker as? CustomImagePickerController)?.imageButton
        imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
