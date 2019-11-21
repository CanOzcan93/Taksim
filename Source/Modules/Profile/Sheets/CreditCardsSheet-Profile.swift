//
//  CreditCardsSheet-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 22.05.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation

extension Profile {
    
    public class CreditCardsSheet: Sheet<CreditCardsLayout> {
        
        public override func onLayoutReady(layout: Profile.CreditCardsLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
            layout.onPlusButtonClicked = {
                self.demonstrator.toAddCardSheet()
            }
            
            if let uToken = self.dataStorage.grabCurrentUser()!.uToken {
                
                if uToken != "" {
                    self.apiManager.creditCardList(uToken: self.dataStorage.grabCurrentUser()!.uToken!) { (json) in
                        print(json)
                    }
                }
                
            }
            
            
            
        }
        
    }
}
