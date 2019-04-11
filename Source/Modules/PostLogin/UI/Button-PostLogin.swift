//
//  Button.swift
//  Taksim
//
//  Created by Can Özcan on 26.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class Button: TSButton {
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.layer.cornerRadius = 20
            
        }
        
        public override func onConstrain() {
            
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        public override func draw(_ rect: CGRect) {
            super.draw(rect)
            self.applyBackgroundGradient(colors: [self.colorProvider.getLightBlue().cgColor,self.colorProvider.getNormalBlue().cgColor], rect: rect)
        }
        
    }
    
}
