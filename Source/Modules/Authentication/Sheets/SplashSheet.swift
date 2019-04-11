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
        
        public override func onLayoutReady(layout: Authentication.SplashLayout) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let phoneNumber = self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) {
                    if let token = self.persistentStorage.recall(key: self.persistentStorage.tokenKey) {
                        self.apiManager.checkToken(token: token as! String) { (json) in
                            if json["errCode"].uIntValue == 0 && json["errCode"].exists(){
                                self.stateMachine.isLoggedInApp(state: true)
                                self.exchangeFlow.letCurrentUser(json: json)
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
