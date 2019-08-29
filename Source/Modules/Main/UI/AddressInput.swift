//
//  AddressInput.swift
//  Taksim
//
//  Created by Can Özcan on 8.08.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class AddressInput: TSCompoundView {
        
        // Internal Fields
        
        public var v_background: TSView!
        private var btn_back: TSImageView!
        private var v_inputBackground: TSView!
        public var ti_address: TextInput!
        
        // MARK: Internal Functions
        
        public func addPlaceholder(_ text: String) {
            ti_address.setPlaceholder(text: text)
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
            constructBackgroundView()
            constructBackButton()
            constructInputBackgroundView()
            constructTextInput()
            
        }
        
        private func constructBackgroundView() {
            
            self.v_background = TSView()
            self.v_background.isOpaque = false
            self.v_background.onDraw = { rect in
                
                self.v_background.layer.sublayers?.removeAll()
                
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
                let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -1, right: 0)), cornerRadius: 8).cgPath
                
                let layer = CAShapeLayer()
                layer.path = path
                layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                
                layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                layer.shadowPath = shadowPath
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0.2
                layer.shadowRadius = 8
                
                self.v_background.layer.insertSublayer(layer, at: 0)
                
            }
            
            self.packView(self.v_background)
            
        }
        
        private func constructBackButton() {
            
            self.btn_back = TSImageView()
            self.btn_back.image = imageProvider.getLeftArrow()
            self.btn_back.onTap {
                self.onBackButtonClicked?()
            }
            
            self.packView(self.btn_back)
            
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
                layer.strokeColor = self.colorProvider.getGrayLight().cgColor
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
        
        private func constructTextInput() {
            
            self.ti_address = TextInput()
            self.ti_address.setPlaceholder(text: "Nereye Gitmek İstiyorsunuz?")
            self.ti_address.font = fontProvider.getRegularMedium()
            
            self.packView(self.ti_address)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            super.onConstrain(set: &set, layout: layout)
            constrainBackgroundView(set: &set, layout: layout)
            constrainBackButton(set: &set, layout: layout)
            constrainInputBackgroundView(set: &set, layout: layout)
            constrainTextInput(set: &set, layout: layout)
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .right, relatedBy: .equal, toItem: layout, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90))
            
        }
        
        private func constrainInputBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .width, relatedBy: .equal, toItem: v_background, attribute: .width, multiplier: 1, constant: -80))
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainBackButton(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: btn_back, attribute: .centerY, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .right, relatedBy: .equal, toItem: v_inputBackground, attribute: .left, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            
        }
        
        private func constrainTextInput(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: ti_address, attribute: .centerY, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_address, attribute: .centerX, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_address, attribute: .width, relatedBy: .equal, toItem: v_inputBackground, attribute: .width, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: ti_address, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
            
        }
        
        
        
    }
    
}



