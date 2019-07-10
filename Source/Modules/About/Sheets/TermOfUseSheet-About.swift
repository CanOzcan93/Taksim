//
//  HelpWebViewSheet-About.swift
//  Taksim
//
//  Created by Can Özcan on 10.07.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension About {
    
    public class TermOfUseSheet: Sheet<TermOfUseLayout> {
        
        public override func onLayoutReady(layout: About.TermOfUseLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
