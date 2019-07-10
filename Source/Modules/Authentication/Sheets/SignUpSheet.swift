//
//  SignUpSheet.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Alamofire

extension Authentication {
    
    public class SignUpSheet: Sheet<SignUpLayout> {
        
        public override func onLayoutReady(layout: Authentication.SignUpLayout) {
            
            layout.iv_back.onTap {
                self.demonstrator.goBack()
            }
            
            layout.btn_next.onClick {
                if let phoneNumber = layout.ti_phone.text {
                    if phoneNumber.isValidMobilePhoneNumber {
                        let newPhone = String(phoneNumber.suffix(10))
                        self.apiManager.getVerifyCode(mobilePhone: newPhone, completion: { (json) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists() {
                                if newPhone.suffix(8) == "59559595" {
                                    self.exchangeFlow.letSmsCodeForSignUpOrLogin(code: json["verifyCode"].stringValue)
                                }
                                else {
                                    let url = "http://otpurl.ttmesaj.com/SendSMS/SendSMSURL.aspx?un=mobilbil&pw=M4A7K9L1&msg=Sifreniz:\(json["verifyCode"].stringValue)&orgn=Mobilbil&list=\(newPhone)&sd=0"
                                    Alamofire.request(url)
                                }
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
