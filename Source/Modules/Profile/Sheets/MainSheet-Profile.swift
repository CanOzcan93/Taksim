//
//  MainSheet-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Profile {
    
    public class MainSheet: Sheet<MainLayout> {
        
        public override func onLayoutReady(layout: Profile.MainLayout) {
            
            if let currentUser = self.exchangeFlow.grabCurrentUser() {
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
                                                           token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String, photo: nil)
                        { (json) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists() {
                                self.exchangeFlow.letCurrentUser(customer: currentUser)
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
        
    }
}
