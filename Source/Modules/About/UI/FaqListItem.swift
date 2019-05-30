//
//  AboutListItem.swift
//  Taksim
//
//  Created by Can Özcan on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import UIKit

extension About {
    
    public class FaqListItem: TSCompoundView {
        
        public var v_background: TSImageView!
        
        private var tv_title: PostLogin.TextView!
        private var tv_text: PostLogin.TextView!
        private var iv_down_arrow: TSImageView!
        
        private var collapsed: Bool!
        
        private var collapsedConstraints: [NSLayoutConstraint]!
        private var expandedConstraints: [NSLayoutConstraint]!
        
        private var sv: UIScrollView!
        
        private var title: String!
        private var text: String!
        
        required init(layout:CoreLayout, scroll: UIScrollView, title: String, text: String) {
            
            self.sv = scroll
            
            self.title = title
            self.text = text
            
            super.init(layout: layout)
            
        }
        required init(layout: CoreLayout) {
            fatalError("init(layout:) has not been implemented")
        }
        
        public override func onConstruct(layout: CoreLayout) {
            
            self.collapsed = true
            
            self.v_background = TSImageView()
            self.v_background.contentMode = .scaleToFill
            self.v_background.image = imageProvider.getRoundedShadow().resizableImage(withCapInsets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
            self.v_background.onTap {
                self.toggle()
            }
            
            self.sv.addSubview(self.v_background)
            
            self.tv_title = PostLogin.TextView()
            self.tv_title.font = fontProvider.getRegularSmall()
            self.tv_title.lineBreakMode = .byWordWrapping
            self.tv_title.numberOfLines = 0
            self.tv_title.text = self.title
            
            self.sv.addSubview(self.tv_title)
            
            
            self.iv_down_arrow = TSImageView()
            self.iv_down_arrow.image = imageProvider.getDownArrow()
            
            self.sv.addSubview(self.iv_down_arrow)
            
            
            self.tv_text = PostLogin.TextView()
            self.tv_text.font = fontProvider.getRegularSmall()
            self.tv_text.lineBreakMode = .byWordWrapping
            self.tv_text.numberOfLines = 0
            self.tv_text.text = self.text
            
            self.sv.addSubview(self.tv_text)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: sv, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: sv, attribute: .centerX, multiplier: 1, constant: 0))
            
            sv.increaseContentHeight(dy: 80)
            
            collapsedConstraints = [
                NSLayoutConstraint(item: tv_title, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -35),
                NSLayoutConstraint(item: tv_text, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0),
            ]
            expandedConstraints = [
                NSLayoutConstraint(item: tv_text, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -40)
            ]
            
            set.append(NSLayoutConstraint(item: tv_title, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: -75))
            set.append(NSLayoutConstraint(item: tv_title, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .top, multiplier: 1, constant: 35))
            set.append(collapsedConstraints[0])
            
            set.append(NSLayoutConstraint(item: iv_down_arrow, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 18))
            set.append(NSLayoutConstraint(item: iv_down_arrow, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: iv_down_arrow, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: iv_down_arrow, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .top, multiplier: 1, constant: 40))
            
            set.append(NSLayoutConstraint(item: tv_text, attribute: .width, relatedBy: .equal, toItem: v_background, attribute: .width, multiplier: 1, constant: -60))
            set.append(NSLayoutConstraint(item: tv_text, attribute: .centerX, relatedBy: .equal, toItem: v_background, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_text, attribute: .top, relatedBy: .equal, toItem: tv_title, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(collapsedConstraints[1])
            
        }
        
        private func toggle() {
            
            if collapsed {
                self.expand()
            } else {
                self.collapse()
            }
            
            self.collapsed = !self.collapsed
            
        }
        
        private func expand() {
            
            self.shift(from: collapsedConstraints, to: expandedConstraints)
            
            UIView.animate(withDuration: 0.4) {
                
                self.relayout()
                
                let textHeight = self.tv_text.bounds.height
                self.sv.increaseContentHeight(dy: textHeight)
                
            }
            
        }
        
        private func collapse() {
            
            self.shift(from: expandedConstraints, to: collapsedConstraints)
            
            let textHeight = self.tv_text.bounds.height
            self.sv.decreaseContentHeight(dy: textHeight)
            
            UIView.animate(withDuration: 0.4) {
                
                self.relayout()
                
            }
            
        }
        
    }
    
}
