//
//  FaqSheet-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension About {
    
    public class FaqSheet: Sheet<FaqLayout> {
        
        public override func onLayoutReady(layout: About.FaqLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
