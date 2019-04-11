//
//  LoginSheet.swift
//  TS
//
//  Created by Erhan Emre Eroğlu on 20.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Foundation

extension Authentication {
    
    public class LoginSheet: Sheet<LoginLayout> {
        
        public override func onLayoutReady(layout: Authentication.LoginLayout) {
            
            layout.ti_phone.text = persistentStorage.recall(key: persistentStorage.phoneNumberKey) as? String
            
            layout.iv_back.onTap {
                self.demonstrator.goBack()
            }
            
            layout.btn_next.onClick {
                if let phoneNumber = layout.ti_phone.text {
                    if phoneNumber.isValidMobilePhoneNumber {
                        let missingChars = 13 - phoneNumber.count
                        var newPhone = phoneNumber
                        if missingChars == 3 {
                            newPhone = "+90\(phoneNumber)"
                        }
                        else if missingChars == 2 {
                            newPhone = "+9\(phoneNumber)"
                        }
                        self.apiManager.getVerifyCode(mobilePhone: newPhone, completion: { (json) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists() {
                                print(json["verifyCode"].stringValue)
                                self.exchangeFlow.letPhoneNumberForSignUpOrLogin(phoneNumber: newPhone)
                                self.demonstrator.toLoginVerificationSheet()
                            }
                        })
                    }
                }
            }
            
        }
        
    }
    
}

extension String {
    public var isValidMobilePhoneNumber: Bool {
        let phoneNumberRegex = "(\\+90|0)?(5)[0-9][0-9][1-9]([0-9]){6}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}
