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
            
            print(self.exchangeFlow.grabCurrentUser()!)
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
