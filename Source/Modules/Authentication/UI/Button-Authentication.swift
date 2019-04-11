//
//  TSFilledButton.swift
//  Authentication
//
//  Created by Erhan Emre Eroğlu on 12.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Authentication {

    public class Button: TSButton {
        
        public override func onConstruct() {
        
            super.onConstruct()
            
            self.setTitleColor(UIColor.black, for: .normal)
            self.backgroundColor = colorProvider.getWhiteFull()
            self.titleLabel?.font = fontProvider.getRegularMedium()
            
        }
        
    }

}
