//
//  CardWebSheet-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 14.11.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class CardWebSheet: Sheet<CardWebLayout> {
        
        public override func onLayoutReady(layout: Profile.CardWebLayout) {
            
            layout.wv.loadHTMLString(self.exchangeFlow.grabCardHtml(), baseURL: nil)
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
