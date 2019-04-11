//
//  SignUpFormSheet.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation

extension Authentication {
    
    public class SignUpFormSheet: Sheet<SignUpFormLayout> {
        
        public override func onLayoutReady(layout: Authentication.SignUpFormLayout) {
            
            layout.iv_back.onTap {
                self.demonstrator.goBack()
            }
            
            layout.btn_next.onClick {
                if layout.ti_email.text != nil && layout.ti_email.text!.isValidEmail {
                    let currentUser = self.exchangeFlow.grabCurrentUser()!
                    currentUser.nickname = "\(layout.ti_name.text ?? "") \(layout.ti_surname.text ?? "")"
                    currentUser.email = layout.ti_email.text ?? ""
                    self.apiManager.updateCustomerInfo(mobilePhone: self.exchangeFlow.grabPhoneNumberForSignUpOrLogin()!, customerInfo: currentUser, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String){ (json) in
                        if json["errCode"].uIntValue == 0 && json["errCode"].exists() {
                            self.exchangeFlow.letCurrentUser(customer: currentUser)
                            self.demonstrator.toMainModule()
                        }
                    }
                }
            }
        }
    }
}

extension String {
    public var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
