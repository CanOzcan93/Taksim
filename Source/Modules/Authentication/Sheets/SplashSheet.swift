//
//  SplashSheet.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Authentication {
    
    public class SplashSheet: Sheet<SplashLayout> {
        
        private var dict_FaqList = [Dictionary<String,String>]()
        
        public override func onLayoutReady(layout: Authentication.SplashLayout) {
            
            apiManager.getFaq { (json) in
                if json["status"].exists() && json["status"].stringValue == "success" {
                    let data = json["data"].arrayValue
                    for datum in data {
                        var dict = Dictionary<String,String>()
                        dict["caption"] = datum["caption"].stringValue
                        dict["content"] = datum["content"].stringValue
                        self.dict_FaqList.append(dict)
                    }
                    self.lexiconProvider.faqDict = self.dict_FaqList
                }
            }
            
            apiManager.version { (json) in
                print("Version\n\(json)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let phoneNumber = self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) {
                    if let token = self.persistentStorage.recall(key: self.persistentStorage.tokenKey) {
                        self.apiManager.checkToken(token: token as! String) { (json, token) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists(){
                                self.stateMachine.isLoggedInApp(state: true)
                                self.persistentStorage.store(key: self.persistentStorage.tokenKey, value: token)
                                print("Token: \(token as! String)")
                                self.dataStorage.letCurrentUser(json: json, completion: nil)
                                if json["currentOrder"]["orderId"].exists() {
                                    self.dataStorage.storeOrderId(id: json["currentOrder"]["orderId"].uIntValue)
                                }
                                self.demonstrator.toMainModule()
                            }
                            else {
                                self.demonstrator.toOnboardingSheet()
                            }
                        }
                    }
                    else {
                        self.demonstrator.toOnboardingSheet()
                    }
                }
                else {
                    self.demonstrator.toOnboardingSheet()
                }
                
            }
            
        }
        
        public override func onLayoutReappear(layout: Authentication.SplashLayout) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let phoneNumber = self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) {
                    if let token = self.persistentStorage.recall(key: self.persistentStorage.tokenKey) {
                        self.apiManager.checkToken(token: token as! String) { (json, token) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists(){
                                self.stateMachine.isLoggedInApp(state: true)
                                self.persistentStorage.store(key: self.persistentStorage.tokenKey, value: token)
                                self.dataStorage.letCurrentUser(json: json, completion: nil)
                                self.demonstrator.toMainModule()
                            }
                            else {
                                self.demonstrator.toOnboardingSheet()
                            }
                        }
                    }
                    else {
                        self.demonstrator.toOnboardingSheet()
                    }
                }
                else {
                    self.demonstrator.toOnboardingSheet()
                }
                
            }
        }
        

        
    }
    
}
