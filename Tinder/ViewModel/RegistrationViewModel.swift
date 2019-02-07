//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Chung Han Hsin on 2019/2/2.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegistrationViewModel{
    var fullName: String?{didSet{checkFormValidity()}}
    var email: String?{didSet{checkFormValidity()}}
    var password: String?{didSet{checkFormValidity()}}
    
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    func performRegistration(completion: @escaping (_ error: Error?) -> ()){
        guard let email = email, let password = password else {return}
        bindaleIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [unowned self](result, error) in
            if let error = error{
                completion(error)
                return
            }
            print("Successfully register user: \(result?.user.uid ?? "")")
            //upload user profile image into firebase storage
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (_ error: Error?) -> ()){
        let fileName = UUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/images/\(fileName)")
        let imageData = self.bindleImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        storageRef.putData(imageData, metadata: nil, completion: { (_, error) in
            if let error = error{
                completion(error)
                return
            }
            print("Sucessfully upload image to storage!")
            storageRef.downloadURL(completion: { [unowned self](url, error) in
                if let error = error{
                    completion(error)
                    return
                }
                //Successfully regitered user in firebase
                self.bindaleIsRegistering.value = false
                print("User pfofile image download url is \(url?.absoluteString ?? "")")
                //just for invoking completion handler when successfully regisytered user
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
            })
        })
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (_ error: Error?) -> ()){
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName" : fullName ?? "", "uid": uid, "imageUrl1" : imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error{
                completion(error)
                return
            }
            print("Suceesfully upload user's information in firestore")
            completion(nil)
        }
    }
    
    //reactive programming
    var bindableIsFormValid = Bindable<Bool>()
    var bindleImage = Bindable<UIImage>()
    var bindaleIsRegistering = Bindable<Bool>()
}
