//
//  Heading.swift
//  TS
//
//  Created by Erhan Emre Eroğlu on 20.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import UIKit

extension Authentication {
    
    public class Heading: TSTextView {
        
        public override func onInit() {
            
            super.onInit()
            
            self.textColor = colorProvider.getWhiteFull()
            self.font = fontProvider.getSemiboldLargest()
            self.textAlignment = .left
            
        }
        
    }
    
}
