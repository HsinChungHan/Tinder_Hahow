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
    
    lazy var headerView: UIView = {
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
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItens()
        setupTableViewLayout()
    }
    
    
    class HeaderLabel: UILabel {
        override func draw(_ rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
    
    //MARK:- UITableView Controller life cycle function
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return headerView
        }
        let headerLabel = HeaderLabel()
        var headerText = ""
        switch section {
        case 1:
            headerText = "Name"
        case 2:
            headerText = "Profession"
        case 3:
            headerText = "Age"
        default:
            headerText = "Bio"
        }
        headerLabel.text = headerText
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingCell.init(style: .default, reuseIdentifier: nil)
        var headerText = ""
        switch indexPath.section {
        case 1:
            headerText = "Enter Name"
        case 2:
            headerText = "Enter Profession"
        case 3:
            headerText = "Enter Age"
        default:
            headerText = "Enter Bio"
        }
        cell.textField.placeholder = headerText
        return cell
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
        tableView.keyboardDismissMode = .interactive
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
