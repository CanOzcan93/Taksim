//
//  MenuItem.swift
//  Taksim
//
//  Created by Can Özcan on 12.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {

    public class MenuItem: TSCompoundView {
        
        
        // Packed Views
        
        private var iv_overlay: TSImageView!
        public var v_ghost: TSView!
        private var iv: TSImageView!
        private var tv: TSTextView!
        
        
        // Required Fields
        
        private var image: UIImage!
        private var text: String!
        
        
        // init
        
        public init(layout: CoreLayout, overlay: TSImageView, image: UIImage, text: String) {
            
            self.iv_overlay = overlay
            self.image = image
            self.text = text
            
            super.init(layout: layout)
            
        }
        required init(layout: CoreLayout) {
            fatalError("init(layout:) has not been implemented")
        }
        required init(scroll: UIScrollView) {
            fatalError("init(scroll:) has not been implemented")
        }
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructGhostView()
            constructIcon()
            constructTextView()
        
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainGhostView(set: &set, layout: layout)
            constrainIcon(set: &set)
            constrainTextView(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructGhostView() {
            
            self.v_ghost = TSView()
            self.v_ghost.isOpaque = false
            
            self.packView(self.v_ghost)
            
        }
        
        private func constructIcon() {
            
            self.iv = TSImageView()
            self.iv.image = image
            
            self.packView(self.iv)
            
        }
        
        private func constructTextView() {
            
            self.tv = TSTextView()
            self.tv.text = text
            self.tv.textColor = colorProvider.getWhiteFull()
            self.tv.font = fontProvider.getRegularMedium()
            
            self.packView(self.tv)
            
        }
        
        private func constrainGhostView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_ghost, attribute: .right, relatedBy: .equal, toItem: iv_overlay, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_ghost, attribute: .width, relatedBy: .equal, toItem: iv_overlay, attribute: .width, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: v_ghost, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 0.04, constant: 0))

        }
        
        private func constrainIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv, attribute: .left, relatedBy: .equal, toItem: v_ghost, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv, attribute: .centerY, relatedBy: .equal, toItem: v_ghost, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: iv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv, attribute: .right, relatedBy: .equal, toItem: v_ghost, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .centerY, relatedBy: .equal, toItem: v_ghost, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: v_ghost, attribute: .width, multiplier: 1, constant: -30))
            set.append(NSLayoutConstraint(item: tv, attribute: .height, relatedBy: .equal, toItem: v_ghost, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
    }
    
}
