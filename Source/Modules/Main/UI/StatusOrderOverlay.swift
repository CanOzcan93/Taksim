//
//  StatusOrderOverlay.swift
//  Taksim
//
//  Created by Can Özcan on 26.06.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class StatusOrderOverlay: TSCompoundView {
        
        
        // Packed Views
        
        private var v_background: TSView!
        private var tv_status: TSTextView!
        private var iv_logo: TSImageView!
        
        // Internal Fields
        
        private var hiddenConstraint: NSLayoutConstraint!
        private var visibleConstraint: NSLayoutConstraint!
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructBackgroundView()
            constructStatusTextView()
            constructLogoImageView()
            
        }
        
        private func constructBackgroundView() {
            
            self.v_background = TSView()
            self.v_background.backgroundColor = UIColor.clear
            self.v_background.onDraw = { rect in
                
                if self.v_background.layer.sublayers == nil {
                    
                    let gradient = CAGradientLayer()
                    let firstColor = self.colorProvider.hexToUIColor(hexString: "33e1ff")
                    let lastColor = self.colorProvider.hexToUIColor(hexString: "3399ff")
                    gradient.colors = [firstColor.cgColor,lastColor.cgColor]
                    gradient.startPoint = CGPoint(x: 0, y: 0)
                    gradient.endPoint = CGPoint(x: 1, y: 0)
                    gradient.frame = rect
                    
                    self.v_background.layer.insertSublayer(gradient, at: 1)
                }
            }
            
            self.packView(self.v_background)
            
        }
        
        private func constructStatusTextView() {
            
            self.tv_status = TSTextView()
            self.tv_status.font = self.fontProvider.getSemiboldBiggest()
            self.tv_status.text = "Taksiniz Yola Çıktı"
            self.tv_status.textColor = self.colorProvider.getWhiteFull()
            self.tv_status.textAlignment = .center
            self.packView(self.tv_status)
            
        }
        
        private func constructLogoImageView() {
            
            self.iv_logo = TSImageView()
            self.iv_logo.image = self.imageProvider.getLogo()
            self.iv_logo.contentMode = .scaleToFill
            self.packView(self.iv_logo)
            
        }

        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainBackgroundView(set: &set, layout: layout)
            constrainStatusTextView(set: &set)
            constrainLogoImageView(set: &set)
            
        }
        
        
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenConstraint = NSLayoutConstraint(item: v_background, attribute: .bottom, relatedBy: .equal, toItem: layout, attribute: .top, multiplier: 1, constant: 0)
            self.visibleConstraint = NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .top, multiplier: 1, constant: 0)
            
            set.append(hiddenConstraint)
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 0.2, constant: 0))
            
        }
        
        private func constrainStatusTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_status, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_status, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 0.85, constant: 0))
            set.append(NSLayoutConstraint(item: tv_status, attribute: .width, relatedBy: .equal, toItem: v_background, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_status, attribute: .height, relatedBy: .equal, toItem: v_background, attribute: .height, multiplier: 0.25, constant: 0))
            
        }
        
        private func constrainLogoImageView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .top, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .width, relatedBy: .equal, toItem: v_background, attribute: .width, multiplier: 0.3, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .height, relatedBy: .equal, toItem: iv_logo, attribute: .width, multiplier: 0.5, constant: 0))
            
        }
        
        
        // Methods
        
        public func show() {
            
            self.shift(from: self.hiddenConstraint, to: self.visibleConstraint)
            
            UIView.animate(withDuration: 0.7) {
                self.relayout()
            }
            
        }
        
        public func hide() {
            
            self.shift(from: self.visibleConstraint, to: hiddenConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        public func changeStatus(text: String) {
            self.tv_status.text = text
        }
        
        
    }
    
}
