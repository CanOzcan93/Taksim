//
//  HelpSheet.swift
//  Taksim
//
//  Created by Can Özcan on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension About {
    
    public class HelpSheet: Sheet<HelpLayout> {
        
        public override func onLayoutReady(layout: About.HelpLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
            layout.lv.items[0].onClickedBar = {
                self.demonstrator.toTermOfUseSheet()
            }
            
            layout.lv.items[1].onClickedBar = {
                self.demonstrator.toAboutUsSheet()
            }
            
            layout.lv.items[2].onClickedBar = {
                self.demonstrator.toPrivacyPolicySheet()
            }
            
        }
    }
}
