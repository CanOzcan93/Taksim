//
//  SocialMenuItem.swift
//  Taksim
//
//  Created by Can Özcan on 13.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class SocialMenuItem: TSCompoundView {

        
        // Packed Views
        
        public var v_ghost: TSView!
        
        private var tv: TSTextView!
        
        private var iv_facebook: TSImageView!
        private var iv_instagram: TSImageView!
        private var iv_twitter: TSImageView!
        
        
        // Required Fields
        
        private var iv_overlay: TSImageView!
        
        
        // init
        
        init(layout: CoreLayout, overlay: TSImageView) {
            
            self.iv_overlay = overlay
            
            super.init(layout: layout)
            
        }
        required init(layout: CoreLayout) {
            super.init(layout: layout)
        }
        required init(scroll: UIScrollView) {
            fatalError("init(scroll:) has not been implemented")
        }
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructGhostView()
            constructTextView()
            
            constructFacebookIcon()
            constructInstagramIcon()
            constructTwitterIcon()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainGhostView(set: &set)
            constrainTextView(set: &set)
            
            constrainFacebookIcon(set: &set)
            constrainInstagramIcon(set: &set)
            constrainTwitterIcon(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructGhostView() {
            
            self.v_ghost = TSView()
            self.v_ghost.isOpaque = false
            
            self.packView(self.v_ghost)
            
        }
        
        private func constructTextView() {
            
            self.tv = TSTextView()
            self.tv.textColor = colorProvider.getWhiteFull()
            self.tv.font = fontProvider.getRegularSmall()
            self.tv.text = lexiconProvider.get("follow_us")
            
            self.packView(self.tv)
            
        }
        
        private func constructFacebookIcon() {
            
            self.iv_facebook = TSImageView()
            self.iv_facebook.image = imageProvider.getFacebook()
            
            self.packView(self.iv_facebook)
            
        }
        
        private func constructInstagramIcon() {
            
            self.iv_instagram = TSImageView()
            self.iv_instagram.image = imageProvider.getInstagram()
            
            self.packView(self.iv_instagram)
            
        }
        
        private func constructTwitterIcon() {
            
            self.iv_twitter = TSImageView()
            self.iv_twitter.image = imageProvider.getTwitter()
            
            self.packView(self.iv_twitter)
            
        }
        
        private func constrainGhostView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_ghost, attribute: .right, relatedBy: .equal, toItem: iv_overlay, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_ghost, attribute: .width, relatedBy: .equal, toItem: iv_overlay, attribute: .width, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: v_ghost, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 85))
            
        }
        
        private func constrainTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv, attribute: .centerX, relatedBy: .equal, toItem: v_ghost, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .top, relatedBy: .equal, toItem: v_ghost, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: v_ghost, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainFacebookIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_facebook, attribute: .left, relatedBy: .equal, toItem: v_ghost, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_facebook, attribute: .top, relatedBy: .equal, toItem: tv, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: iv_facebook, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_facebook, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            
        }
        
        private func constrainInstagramIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_instagram, attribute: .left, relatedBy: .equal, toItem: iv_facebook, attribute: .right, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: iv_instagram, attribute: .top, relatedBy: .equal, toItem: tv, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: iv_instagram, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_instagram, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            
        }
        
        private func constrainTwitterIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_twitter, attribute: .left, relatedBy: .equal, toItem: iv_instagram, attribute: .right, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: iv_twitter, attribute: .top, relatedBy: .equal, toItem: tv, attribute: .bottom, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: iv_twitter, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_twitter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            
        }
        
    }

}
