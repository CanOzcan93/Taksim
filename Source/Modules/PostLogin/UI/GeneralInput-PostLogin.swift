//
//  GeneralInput-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 16.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class GeneralInput: TSCompoundView {
        
        // Internal Fields
        public var v_inputBackground: TSView!
        public var ti: TSTextInput!
        
        // MARK: Internal Functions
        
        public func addPlaceholder(_ text: String) {
            ti.setPlaceholder(text: text)
        }
        
        public var onBackButtonClicked: Action!
        
        /*
         -
         -
         // MARK: Construction
         -
         -
         */
        
        public override func onConstruct(layout: CoreLayout) {
            
            super.onConstruct(layout: layout)
            constructInputBackgroundView()
            constructTextInput(layout: layout)
            
        }
        
        private func constructInputBackgroundView() {
            
            self.v_inputBackground = TSView()
            self.v_inputBackground.layer.isOpaque = false
            self.v_inputBackground.onDraw = { rect in
                self.v_inputBackground.layer.sublayers?.removeAll()
                
                let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/8).cgPath
                let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -1, right: 0)), cornerRadius: 8).cgPath
                
                let layer = CAShapeLayer()
                layer.path = path
                layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                layer.lineWidth = 1
                layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                layer.shadowPath = shadowPath
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0.1
                layer.shadowRadius = 8
                layer.masksToBounds = false
                
                self.v_inputBackground.layer.insertSublayer(layer, at: 0)
            }
            
            self.packView(self.v_inputBackground)
            
        }
        
        private func constructTextInput(layout: CoreLayout) {
            
            self.ti = TSTextInput()
            self.ti.font = fontProvider.getRegularMedium()
            self.ti.textColor = colorProvider.getBlackFull()
            self.ti.activateMovement(layout: layout)
            
            self.packView(self.ti)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            super.onConstrain(set: &set, layout: layout)
            constrainInputBackgroundView(set: &set, layout: layout)
            constrainTextInput(set: &set, layout: layout)
            
        }
        
        private func constrainInputBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainTextInput(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: ti, attribute: .centerY, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .centerX, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .width, relatedBy: .equal, toItem: v_inputBackground, attribute: .width, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: ti, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
            
        }
        
        
        
    }
    
}
