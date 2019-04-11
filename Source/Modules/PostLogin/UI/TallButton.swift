//
//  TallButton.swift
//  Taksim
//
//  Created by E.E.E. on 31.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class TallButton: TSButton {
        
        public override func draw(_ rect: CGRect) {
            super.draw(rect)
            self.applyBackgroundGradient(colors: [colorProvider.getLightBlue().cgColor, colorProvider.getNormalBlue().cgColor], rect: rect)
        }
        
    }
    
}
