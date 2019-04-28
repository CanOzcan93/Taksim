//
//  TextInput-PostLogin.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class TextInput: TSTextInput {
        
        private var drawn: Bool!
        
        public override func onConstruct() {
            
            self.font = fontProvider.getRegularMedium()
            self.textColor = colorProvider.getDarkGray()
            
            self.drawn = false
            
        }
        
        public override func onConstrain() {
            
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
            
        }
        
        public override func draw(_ rect: CGRect) {
            
            super.draw(rect)
            
            if !drawn {
                self.layer.sublayers?.removeAll()
                self.bounds = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
                
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 6).cgPath
                let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)), cornerRadius: 8).cgPath
                
                let layer = CAShapeLayer()
                layer.path = path
                layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                
                layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                layer.shadowPath = shadowPath
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0.1
                layer.shadowRadius = 8
                
                self.layer.insertSublayer(layer, at: 0)
                
                self.drawn = true
            }
            
        }
        
    }
    
}
