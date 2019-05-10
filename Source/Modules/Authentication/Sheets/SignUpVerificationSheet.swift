//
//  SignUpVerificationSheet.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Authentication {
    
    public class SignUpVerificationSheet: Sheet<SignUpVerificationLayout> {
        
        public override func onLayoutReady(layout: Authentication.SignUpVerificationLayout) {
            
            layout.iv_back.onTap {
                self.demonstrator.goBack()
            }
            
            layout.btn_next.onClick {
                if let code = layout.ti_code.text {
                    if let phone = self.exchangeFlow.grabPhoneNumberForSignUpOrLogin() {
                        if let intCode = UInt(code) {
                            self.apiManager.customerLogin(mobilePhone: phone, verifyCode: intCode, completion: { (json, code) in
                                if code != nil {
                                    self.dataStorage.letCurrentUser(json: json,completion: nil)
                                    self.persistentStorage.store(key: self.persistentStorage.phoneNumberKey, value: phone)
                                    self.persistentStorage.store(key: self.persistentStorage.tokenKey, value: code!)
                                    self.demonstrator.toSignUpFormSheet()
                                }
                            })
                        }
                    }
                }
            }
            
        }
        
    }
    
}
