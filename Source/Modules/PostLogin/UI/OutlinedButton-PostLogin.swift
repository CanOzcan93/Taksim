//
//  OutlinedButton-PostLogin.swift
//  Taksim
//
//  Created by Can Özcan on 26.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class OutlinedButton: TSButton {
        
        public override func onConstruct() {
        
            super.onConstruct()
            
            self.setTitleColor(colorProvider.getNormalBlue(), for: .normal)
            self.backgroundColor = colorProvider.getWhiteFull()
            
            
        }
        
        public override func draw(_ rect: CGRect) {
            super.draw(rect)
            self.applyBorderGradient(colors: [colorProvider.getLightBlue().cgColor, colorProvider.getNormalBlue().cgColor], rect: rect)
        }
        
    }
    
}
