//
//  ReviewPopup.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 13.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {

    public class ReviewPopup: TSCompoundView {
        
        // Packed Views
        
        private var v_shade: TSView!
        
        private var v_background: TSView!
        
        private var tv: PostLogin.TextView!
        private var iv_stars: [TSImageView]!
        private var mti: TSMultilineTextInput!
        
        private var btn_cancel: PostLogin.OutlinedButton!
        private var btn_send: PostLogin.Button!
        
        
        // Fields
        
        public var rating: Int!
        
        
        // Internal Fields
        
        private var hiddenShadeConstraint: NSLayoutConstraint!
        private var visibleShadeConstraint: NSLayoutConstraint!
        private var hiddenPopupConstraints: [NSLayoutConstraint]!
        private var visiblePopupConstraints: [NSLayoutConstraint]!
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructShadeView()
            constructBackgroundView()
            
            constructTextView()
            constructStarIcons()
            constructMultilineTextInput()
            
            constructCancelButton()
            constructSendButton()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainShadeView(set: &set, layout: layout)
            constrainBackgroundView(set: &set, layout: layout)
            
            constrainTextView(set: &set)
            constrainStarIcons(set: &set)
            constrainMultilineTextInput(set: &set)
            
            constrainCancelButton(set: &set)
            constrainSendButton(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructShadeView() {
            
            self.v_shade = TSView()
            self.v_shade.backgroundColor = colorProvider.getBlackSoft()
            
            self.packView(self.v_shade)
            
        }
        
        private func constructBackgroundView() {
            
            self.v_background = TSView()
            self.v_background.backgroundColor = colorProvider.getWhiteFull()
            self.v_background.onDraw = { rect in
                
                self.v_background.layer.masksToBounds = true
                self.v_background.layer.cornerRadius = 6
                
            }
            
            self.packView(self.v_background)
            
        }
        
        private func constructTextView() {
            
            self.tv = PostLogin.TextView()
            self.tv.font = fontProvider.getRegularMedium()
            self.tv.textAlignment = .center
            self.tv.text = lexiconProvider.get("rate_trip")
            
            self.packView(self.tv)
            
        }
        
        private func constructStarIcons() {
            
            self.iv_stars = [TSImageView]()
            
            for i in 0...4 {
                
                self.iv_stars.append(TSImageView())
                self.iv_stars[i].image = imageProvider.getOutlinedStar()
                self.iv_stars[i].onTap {
                    
                    self.rating = i
                    self.updateRating()
                    
                }
                
                self.packView(self.iv_stars[i])
                
            }
            
        }
        
        private func constructMultilineTextInput() {
            
            self.mti = TSMultilineTextInput()
            self.mti.font = fontProvider.getRegularSmaller()
            self.mti.textColor = colorProvider.getGrayLight()
            self.mti.text = lexiconProvider.get("comment_phase")
            self.mti.layer.borderColor = colorProvider.getGrayLighter().cgColor
            self.mti.layer.borderWidth = 1
            self.mti.layer.cornerRadius = 8
            self.mti.layer.masksToBounds = true
            self.mti.onBegin = {
                
                if self.mti.text == self.lexiconProvider.get("comment_phase") {
                    self.mti.text = ""
                }
                
                self.mti.textColor = self.colorProvider.getDarkGray()
                
            }
            self.mti.onEnd = {
                
                if self.mti.text == "" {
                    self.mti.text = self.lexiconProvider.get("comment_phase")
                    self.mti.textColor = self.colorProvider.getGrayLight()
                }
                
            }
            
            self.packView(self.mti)
            
        }
        
        private func constructCancelButton() {
            
            self.btn_cancel = PostLogin.OutlinedButton()
            self.btn_cancel.setTitle(self.lexiconProvider.get("cancel"), for: .normal)
            self.btn_cancel.layer.cornerRadius = 20
            self.btn_cancel.onClick {
                self.hide()
            }
            
            self.packView(self.btn_cancel)
            
        }
        
        private func constructSendButton() {
            
            self.btn_send = PostLogin.Button()
            self.btn_send.setTitle(self.lexiconProvider.get("send"), for: .normal)
            self.btn_send.layer.cornerRadius = 20
            
            self.packView(self.btn_send)
            
        }
        
        private func constrainShadeView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .right, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0)
            self.visibleShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0)
            
            set.append(hiddenShadeConstraint)
            set.append(NSLayoutConstraint(item: v_shade, attribute: .centerY, relatedBy: .equal, toItem: layout, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_shade, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_shade, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenPopupConstraints = [
                NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: -45),
                NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 295)
            ]
            
            self.visiblePopupConstraints = [
                NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: -40),
                NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
            ]
            
            set.append(hiddenPopupConstraints[0])
            set.append(hiddenPopupConstraints[1])
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: v_shade, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerY, relatedBy: .equal, toItem: v_shade, attribute: .centerY, multiplier: 1, constant: 0))
            
        }
        
        private func constrainTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: -105))
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 270))
            set.append(NSLayoutConstraint(item: tv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35))
            
        }
        
        private func constrainStarIcons(set: inout [NSLayoutConstraint]) {
            
            for i in 0...4 {
                set.append(NSLayoutConstraint(item: iv_stars[i], attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: -60))
                set.append(NSLayoutConstraint(item: iv_stars[i], attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
                set.append(NSLayoutConstraint(item: iv_stars[i], attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            }
            
            set.append(NSLayoutConstraint(item: iv_stars[0], attribute: .right, relatedBy: .equal, toItem: iv_stars[1], attribute: .left, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: iv_stars[1], attribute: .right, relatedBy: .equal, toItem: iv_stars[2], attribute: .left, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: iv_stars[2], attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_stars[3], attribute: .left, relatedBy: .equal, toItem: iv_stars[2], attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: iv_stars[4], attribute: .left, relatedBy: .equal, toItem: iv_stars[3], attribute: .right, multiplier: 1, constant: 5))
            
            
        }
        
        private func constrainMultilineTextInput(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: mti, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: mti, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 25))
            set.append(NSLayoutConstraint(item: mti, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 270))
            set.append(NSLayoutConstraint(item: mti, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
            
        }
        
        private func constrainCancelButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 90))
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: btn_cancel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainSendButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_send, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 90))
            set.append(NSLayoutConstraint(item: btn_send, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: btn_send, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: btn_send, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func updateRating() {
            
            for i in 0...4 {
                if i <= rating {
                    self.iv_stars[i].image = imageProvider.getFilledStar()
                } else {
                    self.iv_stars[i].image = imageProvider.getOutlinedStar()
                }
            }
            
        }
        
        
        // Methods
        
        public func show() {
            
            self.shift(from: hiddenShadeConstraint, to: visibleShadeConstraint)
            
            self.relayout()
            
            self.shift(from: hiddenPopupConstraints[0], to: visiblePopupConstraints[0])
            self.shift(from: hiddenPopupConstraints[1], to: visiblePopupConstraints[1])
            
            UIView.animate(withDuration: 0.25) {
                self.relayout()
            }
            
        }
        
        public func hide() {
            
            self.shift(from: visiblePopupConstraints[0], to: hiddenPopupConstraints[0])
            self.shift(from: visiblePopupConstraints[1], to: hiddenPopupConstraints[1])
            
            UIView.animate(withDuration: 0.1, animations: {
                
                self.relayout()
                
            }, completion: { animated in
                
                self.shift(from: self.visibleShadeConstraint, to: self.hiddenShadeConstraint)
                
                self.relayout()
                
            })
            
        }
        
    }
    
}
