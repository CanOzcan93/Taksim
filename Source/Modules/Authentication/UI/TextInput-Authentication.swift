//
//  TSATextField.swift
//  Authentication
//
//  Created by Can Özcan on 12.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import UIKit

extension Authentication {
    
    public class TextInput: TSTextInput {
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.textColor = colorProvider.getWhiteFull()
            self.font = fontProvider.getRegularMedium()
            
            let h = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
            
            let line: TSView = TSView()
            line.backgroundColor = colorProvider.getWhiteFull()
            
            self.addSubview(line)
            
            let ha = NSLayoutConstraint(item: line, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            let va = NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            
            let w = NSLayoutConstraint(item: line, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
            let hh = NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
            
            self.addConstraints([h, ha, va, w, hh])
            
        }
        
        open override func setPlaceholder(text: String) {
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: colorProvider.getGrayLightest()])
        }
        
    }
    
}
