//
//  VerificationPage.swift
//  TS
//
//  Created by Erhan Emre Eroğlu on 20.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Foundation

extension Authentication {
    
    public class LoginVerificationSheet: Sheet<LoginVerificationLayout> {
        
        public override func onLayoutReady(layout: Authentication.LoginVerificationLayout) {

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
                                    self.demonstrator.toMainModule()
                                }
                            })
                        }
                    }
                }
            }
            
        }
        
    }
    
}
