//
//  MenuOverlay.swift
//  Taksim
//
//  Created by Can Özcan on 4.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class MenuOverlay: TSCompoundView {
        
        
        // Internal Fields
        
        private var v_shade: TSView!
        private var iv_overlay: TSImageView!
        
        public var iv_avatar: TSImageView!
        
        private var mi_profile: MenuItem!
        private var mi_cards: MenuItem!
        private var mi_addresses: MenuItem!
        
        private var v_line_1: TSView!
        
        private var mi_notifications: MenuItem!
        private var mi_promotion: MenuItem!
        private var mi_trips: MenuItem!
        private var mi_help: MenuItem!
        private var mi_faq: MenuItem!
        
        private var v_line_2: TSView!
        
        private var mi_social: SocialMenuItem!
        
        private var v_line_3: TSView!
        
        private var mi_exit: MenuItem!
        
        
        
        // API
        
        public var onProfileClick: Action?
        public var onNotificationsClick: Action?
        public var onPromotionClick: Action?
        public var onHelpClick: Action?
        public var onFaqClick: Action?
        public var onTripsClick: Action?
        public var onExitClick: Action?
        
        
        // Internal Fields
        
        private var hiddenShadeConstraint: NSLayoutConstraint!
        private var visibleShadeConstraint: NSLayoutConstraint!
        private var hiddenOverlayConstraint: NSLayoutConstraint!
        private var visibleOverlayConstraint: NSLayoutConstraint!
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructShadeView()
            constructOverlayImage()
            
            constructAvatarImage()
            
            constructFirstMenuStack(layout: layout)
            constructFirstLine()
            constructSecondMenuStack(layout: layout)
            constructSecondLine()
            constructSocialStack(layout: layout)
            constructThirdLine()
            constructExitItem(layout: layout)
            
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainShadeView(set: &set, layout: layout)
            constrainOverlayImage(set: &set, layout: layout)
            
            constrainAvatarImage(set: &set)
            
            constrainFirstMenuStack(set: &set)
            constrainFirstLine(set: &set)
            constrainSecondMenuStack(set: &set)
            constrainSecondLine(set: &set)
            constrainSocialStack(set: &set)
            constrainThirdLine(set: &set)
            constrainExitItem(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructShadeView() {
            
            self.v_shade = TSView()
            self.v_shade.backgroundColor = colorProvider.getBlackSoft()
            self.v_shade.onTap {
                self.hide()
            }
            
            self.packView(self.v_shade)
            
        }
        
        private func constructOverlayImage() {
            
            self.iv_overlay = TSImageView()
            self.iv_overlay.image = imageProvider.getMenuBackground()
            
            self.packView(self.iv_overlay)
            
        }
        
        private func constructAvatarImage() {
            
            self.iv_avatar = TSImageView()
            self.iv_avatar.image = imageProvider.getAvatar()
            
            self.packView(self.iv_avatar)
            
        }
        
        private func constructFirstMenuStack(layout: CoreLayout) {
            
            self.mi_profile = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getProfile(), text: lexiconProvider.get("profile"))
            self.mi_profile.v_ghost.onTap {
                self.onProfileClick?()
            }
            
            self.mi_cards = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getCreditCard(), text: lexiconProvider.get("credit_cards"))
            self.mi_addresses = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getHome(), text: lexiconProvider.get("locations"))
            
        }
        
        private func constructFirstLine() {
            
            self.v_line_1 = TSView()
            self.v_line_1.backgroundColor = colorProvider.getWhiteSoft()
           
            self.packView(self.v_line_1)
            
        }
        
        private func constructSecondMenuStack(layout: CoreLayout) {
            
            self.mi_notifications = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getBell(), text: lexiconProvider.get("notifications"))
            self.mi_notifications.v_ghost.onTap {
                self.onNotificationsClick?()
            }
            
            self.mi_promotion = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getPresent(), text: lexiconProvider.get("promotion"))
            self.mi_promotion.v_ghost.onTap {
                self.onPromotionClick?()
            }
            
            self.mi_trips = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getList(), text: lexiconProvider.get("trips"))
            self.mi_trips.v_ghost.onTap{
                self.onTripsClick?()
            }
            
            self.mi_help = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getHelp(), text: lexiconProvider.get("help"))
            self.mi_help.v_ghost.onTap {
                self.onHelpClick?()
            }
            
            self.mi_faq = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getSpeechBubble(), text: lexiconProvider.get("faq"))
            self.mi_faq.v_ghost.onTap {
                self.onFaqClick?()
            }
            
        }
        
        private func constructSecondLine() {
            
            self.v_line_2 = TSView()
            self.v_line_2.backgroundColor = colorProvider.getWhiteSoft()
           
            self.packView(self.v_line_2)
            
        }
        
        private func constructSocialStack(layout: CoreLayout) {
            
            self.mi_social = SocialMenuItem(layout: layout, overlay: iv_overlay)
            
        }
        
        private func constructThirdLine() {
            
            self.v_line_3 = TSView()
            self.v_line_3.backgroundColor = colorProvider.getWhiteSoft()
            
            self.packView(self.v_line_3)
            
        }
        
        private func constructExitItem(layout: CoreLayout) {
            
            self.mi_exit = MenuItem(layout: layout, overlay: iv_overlay, image: imageProvider.getExit(), text: lexiconProvider.get("exit"))
            self.mi_exit.v_ghost.onTap {
                self.onExitClick?()
            }
            
        }
        
        private func constrainShadeView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .right, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0)
            self.visibleShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0)
            
            set.append(hiddenShadeConstraint)
            set.append(NSLayoutConstraint(item: v_shade, attribute: .centerY, relatedBy: .equal, toItem: layout, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_shade, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_shade, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainOverlayImage(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenOverlayConstraint = NSLayoutConstraint(item: iv_overlay, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: -240)
            self.visibleOverlayConstraint = NSLayoutConstraint(item: iv_overlay, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0)
            
            set.append(hiddenOverlayConstraint)
            set.append(NSLayoutConstraint(item: iv_overlay, attribute: .centerY, relatedBy: .equal, toItem: layout, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_overlay, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 240))
            set.append(NSLayoutConstraint(item: iv_overlay, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainAvatarImage(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .centerX, relatedBy: .equal, toItem: iv_overlay, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .top, relatedBy: .equal, toItem: iv_overlay, attribute: .top, multiplier: 1, constant: 50))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
            
        }
        
        private func constrainFirstMenuStack(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: mi_profile.v_ghost, attribute: .top, relatedBy: .equal, toItem: iv_avatar, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: mi_cards.v_ghost, attribute: .top, relatedBy: .equal, toItem: mi_profile.v_ghost, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: mi_addresses.v_ghost, attribute: .top, relatedBy: .equal, toItem: mi_cards.v_ghost, attribute: .bottom, multiplier: 1, constant: 0))
            
        }
        
        private func constrainFirstLine(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_line_1, attribute: .centerX, relatedBy: .equal, toItem: iv_overlay, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line_1, attribute: .top, relatedBy: .equal, toItem: mi_addresses.v_ghost, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: v_line_1, attribute: .width, relatedBy: .equal, toItem: iv_overlay, attribute: .width, multiplier: 1, constant: -70))
            set.append(NSLayoutConstraint(item: v_line_1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
            
        }
        
        private func constrainSecondMenuStack(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: mi_notifications.v_ghost, attribute: .top, relatedBy: .equal, toItem: v_line_1, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: mi_promotion.v_ghost, attribute: .top, relatedBy: .equal, toItem: mi_notifications.v_ghost, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: mi_trips.v_ghost, attribute: .top, relatedBy: .equal, toItem: mi_promotion.v_ghost, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: mi_help.v_ghost, attribute: .top, relatedBy: .equal, toItem: mi_trips.v_ghost, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: mi_faq.v_ghost, attribute: .top, relatedBy: .equal, toItem: mi_help.v_ghost, attribute: .bottom, multiplier: 1, constant: 0))
            
        }
        
        private func constrainSecondLine(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_line_2, attribute: .centerX, relatedBy: .equal, toItem: iv_overlay, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line_2, attribute: .top, relatedBy: .equal, toItem: mi_faq.v_ghost, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: v_line_2, attribute: .width, relatedBy: .equal, toItem: iv_overlay, attribute: .width, multiplier: 1, constant: -70))
            set.append(NSLayoutConstraint(item: v_line_2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
            
        }
        
        private func constrainSocialStack(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: mi_social.v_ghost, attribute: .top, relatedBy: .equal, toItem: v_line_2, attribute: .bottom, multiplier: 1, constant: 5))
            
        }
        
        private func constrainThirdLine(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_line_3, attribute: .centerX, relatedBy: .equal, toItem: iv_overlay, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line_3, attribute: .top, relatedBy: .equal, toItem: mi_social.v_ghost, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: v_line_3, attribute: .width, relatedBy: .equal, toItem: iv_overlay, attribute: .width, multiplier: 1, constant: -70))
            set.append(NSLayoutConstraint(item: v_line_3, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
            
        }
        
        private func constrainExitItem(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: mi_exit.v_ghost, attribute: .top, relatedBy: .equal, toItem: v_line_3, attribute: .bottom, multiplier: 1, constant: 10))
            
        }
        
        // Methods
        
        public func show() {
            
            self.shift(from: hiddenShadeConstraint, to: visibleShadeConstraint)
            
            self.relayout()
            
            self.release(constraint: hiddenOverlayConstraint)
            self.constrain(constraint: visibleOverlayConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        public func hide() {
            
            UIView.animate(withDuration: 0.4, animations: {
               
                self.shift(from: self.visibleOverlayConstraint, to: self.hiddenOverlayConstraint)
                
                self.relayout()
                
            }) { (animated) in
                
                self.shift(from: self.visibleShadeConstraint, to: self.hiddenShadeConstraint)
                
                self.relayout()
                
            }
        }
        
        
    }
    
}
