//
//  MainSheet-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class MainSheet: Sheet<MainLayout> {
        
        public override func onLayoutReady(layout: Profile.MainLayout) {
            
            if let currentUser = self.dataStorage.grabCurrentUser() {
                if let picture = currentUser.profilePicture {
                    let scaledImage = picture.scaleImageToFitSize(size: CGSize(width: 100, height: 100))
                    layout.iv_avatar.image = scaledImage.roundedImage
                }
                var nameAndSurnameArray = currentUser.nickname.components(separatedBy: " ")
                if nameAndSurnameArray.count < 2 {
                    layout.ti_name.text = nameAndSurnameArray.first
                }
                else {
                    layout.ti_surname.text = nameAndSurnameArray.removeLast()
                    layout.ti_name.text = nameAndSurnameArray.joined(separator: " ")
                    
                }
                layout.ti_email.text = currentUser.email
                if let phoneNumber = self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) as? String {
                    layout.ti_phone.text = phoneNumber
                }
                layout.btn_save.onClick {
                    if layout.ti_email.text != nil && layout.ti_email.text!.isValidEmail {
                        currentUser.nickname = "\(layout.ti_name.text ?? "") \(layout.ti_surname.text ?? "")"
                        currentUser.email = layout.ti_email.text!
                        self.apiManager.updateCustomerInfo(mobilePhone: self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) as! String,
                                                           customerInfo: currentUser,
                                                           token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String, photo: self.exchangeFlow.grabProfilePhotoChanged())
                        { (json) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists() {
                                self.dataStorage.letCurrentUser(json: json, completion: { image in
                                    layout.iv_avatar.image = image
                                })
                                self.exchangeFlow.resetProfilePhotoChanged()
                                self.demonstrator.goBack()
                            }
                        }
                    }
                }
            }
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
            layout.iv_plus.onTap {
                self.demonstrator.toPhotoShootSheet()
            }
            
        }
     
        public override func onLayoutReappear(layout: Profile.MainLayout) {
            
            if let changedPhoto = self.exchangeFlow.grabProfilePhotoChanged() {
                let scaledImage = changedPhoto.scaleImageToFitSize(size: CGSize(width: 100, height: 100))
                layout.iv_avatar.image = scaledImage.roundedImage
            }
            else {
                if let curUser = self.dataStorage.grabCurrentUser()
                {
                    if let picture = curUser.profilePicture {
                        let scaledImage = picture.scaleImageToFitSize(size: CGSize(width: 100, height: 100))
                        layout.iv_avatar.image = scaledImage.roundedImage
                    }
                }
            }
            
            
        }
        
    }
}
