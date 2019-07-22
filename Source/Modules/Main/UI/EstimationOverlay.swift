//
//  EstimationOverlay.swift
//  Taksim
//
//  Created by Can Özcan on 28.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class EstimationOverlay: TSCompoundView {

        
        // Packed Views
        
        private var v_background: TSView!
        
        private var tv_left: TSTextView!
        private var tv_center: TSTextView!
        private var tv_right: TSTextView!
        private var v_left: TSView!
        private var v_right: TSView!
        
        private var btn: PostLogin.TallButton!
        private var btn_cancel: PostLogin.CancelButton!
        public var onOrder: Action?
        public var onCancel: Action?
        
        
        // Internal Fields
        
        private var hiddenConstraint: NSLayoutConstraint!
        private var visibleConstraint: NSLayoutConstraint!

        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructBackgroundView()
            constructUpperStack()
            constructButton()
            constructCancelButton()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainBackgroundView(set: &set, layout: layout)
            
            constrainLeftMostTextView(set: &set)
            constrainLeftSeperator(set: &set)
            constrainCenterTextView(set: &set)
            constrainRightSeperator(set: &set)
            constrainRightMostTextView(set: &set)
            
            constrainButton(set: &set, layout: layout)
            constrainButtonCancel(set: &set, layout: layout)
            
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
        
        private func constructUpperStack() {
            
            self.tv_left = TSTextView()
            self.tv_left.text = "40 km"
            self.tv_left.textAlignment = .center
            
            self.packView(self.tv_left)
            
            
            self.v_left = TSView()
            self.v_left.frame = CGRect(x: 0, y: 0, width: 1, height: 22.5)
            self.v_left.backgroundColor = UIColor.darkGray
            
            self.packView(self.v_left)
            
            
            self.tv_center = TSTextView()
            self.tv_center.text = "12 dk"
            self.tv_center.textAlignment = .center
            
            self.packView(self.tv_center)
            
            
            self.v_right = TSView()
            self.v_right.frame = CGRect(x: 0, y: 0, width: 1, height: 22.5)
            self.v_right.backgroundColor = UIColor.darkGray
            
            self.packView(self.v_right)
            
            
            self.tv_right = TSTextView()
            self.tv_right.text = "32 TL"
            self.tv_right.textAlignment = .center
            
            self.packView(self.tv_right)
            
        }
        
        private func constructButton() {
            
            self.btn = PostLogin.TallButton()
            self.btn.setTitle("Taksim Gelsin", for: .normal)
            self.btn.onClick {
                self.onOrder?()
            }
            
            self.packView(self.btn)
            
        }
        
        private func constructCancelButton() {
            self.btn_cancel = PostLogin.CancelButton()
            self.btn_cancel.setTitle("X", for: .normal)
            self.btn_cancel.onClick {
                self.onCancel?()
            }
            
            self.packView(self.btn_cancel)
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenConstraint = NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
            self.visibleConstraint = NSLayoutConstraint(item: v_background, attribute: .bottom, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
            
            set.append(hiddenConstraint)
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 180))
            
        }
        
        private func constrainLeftMostTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_left, attribute: .centerY, relatedBy: .equal, toItem: tv_center, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_left, attribute: .right, relatedBy: .equal, toItem: v_left, attribute: .left, multiplier: 1, constant: -1))
            set.append(NSLayoutConstraint(item: tv_left, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 80))
            set.append(NSLayoutConstraint(item: tv_left, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22.5))
            
        }
        
        private func constrainLeftSeperator(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_left, attribute: .centerY, relatedBy: .equal, toItem: tv_center, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_left, attribute: .right, relatedBy: .equal, toItem: tv_center, attribute: .left, multiplier: 1, constant: -1))
            set.append(NSLayoutConstraint(item: v_left, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1))
            set.append(NSLayoutConstraint(item: v_left, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22.5))
            
        }
        
        private func constrainCenterTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_center, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_center, attribute: .bottom, relatedBy: .equal, toItem: btn, attribute: .top, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: tv_center, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 80))
            set.append(NSLayoutConstraint(item: tv_center, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22.5))
            
        }
        
        private func constrainRightSeperator(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_right, attribute: .centerY, relatedBy: .equal, toItem: tv_center, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_right, attribute: .left, relatedBy: .equal, toItem: tv_center, attribute: .right, multiplier: 1, constant: 1))
            set.append(NSLayoutConstraint(item: v_right, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 1))
            set.append(NSLayoutConstraint(item: v_right, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22.5))
            
        }
        
        private func constrainRightMostTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_right, attribute: .centerY, relatedBy: .equal, toItem: tv_center, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_right, attribute: .left, relatedBy: .equal, toItem: v_right, attribute: .right, multiplier: 1, constant: 1))
            set.append(NSLayoutConstraint(item: tv_right, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 80))
            set.append(NSLayoutConstraint(item: tv_right, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22.5))
            
        }
        
        private func constrainButton(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: btn, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: btn, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 0.8, constant: 0))
            
        }
        
        private func constrainButtonCancel(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
            
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
        
        public func fillAttributes(distance: Int, duration: Int) {
            self.tv_left.text = "\(distance/1000) Km"
            self.tv_center.text = "\(duration/60) Dk"
            var payment = Int(Double(distance/1000) * 3.7 + 3.9)
            if payment < 10 {
                payment = 10
            }
            self.tv_right.text = "\(payment) TL"
        }
    
        
    }
    
}
