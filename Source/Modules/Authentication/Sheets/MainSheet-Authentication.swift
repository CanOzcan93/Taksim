//
//  MainSheet.swift
//  TS
//
//  Created by Can Özcan on 20.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

extension Authentication {
    
    public class MainSheet: Sheet<MainLayout> {
        
        public override func onLayoutReady(layout: Authentication.MainLayout) {
            
            layout.btnLogin.onClick {
                self.demonstrator.toLoginSheet()
            }
            
            layout.btnSignUp.onClick {
                self.demonstrator.toSignUpSheet()
            }
            
        }
        
    }
    
}
