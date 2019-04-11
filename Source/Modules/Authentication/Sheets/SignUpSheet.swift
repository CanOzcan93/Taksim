//
//  SignUpSheet.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Authentication {
    
    public class SignUpSheet: Sheet<SignUpLayout> {
        
        public override func onLayoutReady(layout: Authentication.SignUpLayout) {
            
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
                                self.demonstrator.toSignUpVerificationSheet()
                            }
                        })
                    }
                }
            }
            
        }
        
    }
    
}
