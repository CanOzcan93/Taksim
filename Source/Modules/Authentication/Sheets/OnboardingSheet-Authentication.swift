//
//  OnboardingSheet-Authentication.swift
//  Taksim
//
//  Created by Can Özcan on 22.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation

extension Authentication {
    
    public class OnboardingSheet: Sheet<OnboardingLayout> {
        
        public override func onLayoutReady(layout: Authentication.OnboardingLayout) {
            
            layout.btn.onClick {
            
                self.demonstrator.toMainSheet()
                
            }
            
        }
        
    }
    
}
