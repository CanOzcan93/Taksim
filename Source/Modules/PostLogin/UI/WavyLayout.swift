//
//  BaseScreenLayout.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class WavyLayout: TSLayout {
        
        
        // Fields
        
        private var iv_background: TSImageView!
        
        private var tv_heading: TSTextView!
        private var btn_back: TSImageView!
        
        
        // API
        
        public var onBackButtonClicked: Action!
        
        
        // Virtuals
        
        open func onHeading() -> String { return "" }
        
        public override func onConstruct() {
            
            self.iv_background = TSImageView()
            self.iv_background.image = imageProvider.getLightWaves()
            self.addSubview(self.iv_background)
            
            self.btn_back = TSImageView()
            self.btn_back.image = imageProvider.getLeftArrow()
            self.btn_back.onTap {
                self.onBackButtonClicked?()
            }
            self.addSubview(self.btn_back)
            
            self.tv_heading = TSTextView()
            self.tv_heading.text = onHeading()
            self.tv_heading.font = fontProvider.getSemiboldLarge()
            self.tv_heading.textColor = colorProvider.getDarkGray()
            self.tv_heading.textAlignment = .center
            
            self.addSubview(self.tv_heading)
            
        }
        
        open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.endEditing(true)
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
        
            set.append(NSLayoutConstraint(item: iv_background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
            set.append(NSLayoutConstraint(item: btn_back, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 39))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 12))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
            
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 40))
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 150))
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))

        }
        
    }
    
}
