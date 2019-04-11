//
//  TSPopup.swift
//  Taksim
//
//  Created by Can Özcan on 26.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Main {

    public class CancellationPopup : TSCompoundView {
        
        
        // Packed Views
        
        private var v_shade: TSView!
        
        private var v_background: TSView!
        
        private var tv: PostLogin.TextView!
        private var btn_yes: PostLogin.OutlinedButton!
        private var btn_no: PostLogin.Button!
        
        
        public var onYes: Action!
        
        // Internal Fields
        
        private var hiddenShadeConstraint: NSLayoutConstraint!
        private var visibleShadeConstraint: NSLayoutConstraint!
        private var hiddenPopupConstraints: [NSLayoutConstraint]!
        private var visiblePopupConstraints: [NSLayoutConstraint]!
        
        
        // Implementation
        
        open override func onConstruct(layout: CoreLayout) {
            
            constructShadeView()
            constructBackgroundView()
            
            constructTextView()
            constructYesButton()
            constructNoButton()
            
        }
        
        open override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainShadeView(set: &set, layout: layout)
            constrainBackgroundView(set: &set, layout: layout)
            
            constrainTextView(set: &set)
            constrainYesButton(set: &set)
            constrainNoButton(set: &set)
            
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
            self.tv.lineBreakMode = .byWordWrapping
            self.tv.numberOfLines = 2
            self.tv.text = lexiconProvider.get("cancellation")+"?"
            
            self.packView(self.tv)
            
        }
        
        private func constructYesButton() {
            
            self.btn_yes = PostLogin.OutlinedButton()
            self.btn_yes.setTitle(lexiconProvider.get("yes"), for: .normal)
            self.btn_yes.layer.cornerRadius = 20
            self.btn_yes.onClick {
                self.onYes?()
            }
            
            self.packView(self.btn_yes)
            
        }
        
        private func constructNoButton() {
            
            self.btn_no = PostLogin.Button()
            self.btn_no.setTitle(lexiconProvider.get("no"), for: .normal)
            self.btn_no.layer.cornerRadius = 20
            self.btn_no.onClick {
                self.hide()
            }
            
            self.packView(self.btn_no)
            
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
                NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 155)
            ]
            
            self.visiblePopupConstraints = [
                NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: -40),
                NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 160)
            ]
            
            set.append(hiddenPopupConstraints[0])
            set.append(hiddenPopupConstraints[1])
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: v_shade, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerY, relatedBy: .equal, toItem: v_shade, attribute: .centerY, multiplier: 1, constant: 0))
            
        }
        
        private func constrainTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: tv, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 270))
            set.append(NSLayoutConstraint(item: tv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
            
        }
        
        private func constrainYesButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_yes, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: btn_yes, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: btn_yes, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: btn_yes, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainNoButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_no, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: btn_no, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: btn_no, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: btn_no, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
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
