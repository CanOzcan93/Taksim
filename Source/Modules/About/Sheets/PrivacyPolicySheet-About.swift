//
//  PrivacyPolicySheet-About.swift
//  Taksim
//
//  Created by Can Özcan on 10.07.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation

extension About {
    
    public class PrivacyPolicySheet: Sheet<PrivacyPolicyLayout> {
        
        public override func onLayoutReady(layout: About.PrivacyPolicyLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
