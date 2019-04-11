//
//  QuickOrderOverlay.swift
//  Taksim
//
//  Created by Can Özcan on 5.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class QuickOrderOverlay: TSCompoundView {
        
        
        // Packed Views
        
        private var v_background: TSView!
        
        private var btn: PostLogin.TallButton!
        public var onOrder: Action?
        
        
        // Internal Fields
        
        private var hiddenConstraint: NSLayoutConstraint!
        private var visibleConstraint: NSLayoutConstraint!
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructBackgroundView()
            
            constructButton()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainBackgroundView(set: &set, layout: layout)
            
            constrainButton(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructBackgroundView() {
            
            self.v_background = TSView()
            self.v_background.backgroundColor = UIColor.clear
            self.v_background.onDraw = { rect in
                
                if self.v_background.layer.sublayers == nil {
                    
                    let layer = CALayer()
                    layer.backgroundColor = UIColor.white.cgColor
                    
                    let gradientLayer = CAGradientLayer()
                    gradientLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
                    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
                    gradientLayer.frame = rect
                    
                    self.v_background.layer.insertSublayer(gradientLayer, at: 0)
                }
            }
            
            self.packView(self.v_background)
            
        }
        
        private func constructButton() {
            
            self.btn = PostLogin.TallButton()
            self.btn.setTitle("Taksim Gelsin", for: .normal)
            self.btn.onClick {
                self.onOrder?()
            }
            
            self.packView(self.btn)
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenConstraint = NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
            self.visibleConstraint = NSLayoutConstraint(item: v_background, attribute: .bottom, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
            
            set.append(hiddenConstraint)
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 120))
            
        }
        
        private func constrainButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: btn, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 305))
            
        }
        
        
        // Methods
        
        public func show() {
            
            self.shift(from: self.hiddenConstraint, to: self.visibleConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        public func hide() {
            
            self.shift(from: self.visibleConstraint, to: hiddenConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        
    }
    
}

