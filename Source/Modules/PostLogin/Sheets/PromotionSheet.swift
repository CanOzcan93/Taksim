//
//  PromotionSheet.swift
//  Taksim
//
//  Created by Can Özcan on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension PostLogin {
    
    public class PromotionSheet: Sheet<PromotionLayout> {
        
        public override func onLayoutReady(layout: PostLogin.PromotionLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
    
}


