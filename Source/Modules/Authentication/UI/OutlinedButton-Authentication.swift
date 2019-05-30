//
//  TSOutlinedButton.swift
//  Authentication
//
//  Created by Can Özcan on 12.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import UIKit

extension Authentication {
    
    public class OutlinedButton: TSButton {
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.backgroundColor = colorProvider.getTransparent()
            self.layer.borderColor = colorProvider.getWhiteFull().cgColor
            self.layer.borderWidth = 2
            
        }
        
    }
    
}
