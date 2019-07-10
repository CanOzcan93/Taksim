//
//  AboutUsSheet-About.swift
//  Taksim
//
//  Created by Can Özcan on 10.07.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension About {
    
    public class AboutUsSheet: Sheet<AboutUsLayout> {
        
        public override func onLayoutReady(layout: About.AboutUsLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
