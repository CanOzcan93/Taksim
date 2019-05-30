//
//  TaksimLayout.swift
//  Authentication
//
//  Created by Can Özcan on 12.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Authentication {

    open class FunnelLayout: TSLayout {

        
        // Fields
        
        public var iv_background: TSImageView!
        public var iv_back: TSImageView!
        public var iv_logo: TSImageView!
        public var tv_heading: TSTextView!
        public var tv_info: TSTextView!
        
        
        // Virtuals
        
        open func onHeading() -> String { return "" }
        open func onInfo() -> String { return "" }
        
        
        // Implementation
        
        open override func onConstruct() {
            
            super.onConstruct()
            
            constructBackgroundImage()
            constructBackButton()
            constructLogo()
            constructHeading()
            constructInfo()
            
            self.addSubview(iv_background)
            self.addSubview(iv_back)
            self.addSubview(iv_logo)
            self.addSubview(tv_heading)
            self.addSubview(tv_info)
            
        }
        
        open override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            constrainBackground(set: &set)
            constrainBackButton(set: &set)
            constrainLogo(set: &set)
            constrainHeading(set: &set)
            constrainInfo(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructBackgroundImage() {
            
            iv_background = TSImageView()
            iv_background.image = imageProvider.getBackgroundImage()
            
        }
        
        private func constructBackButton() {
            
            iv_back = TSImageView()
            iv_back.image = imageProvider.getWhiteLeftArrow()
            
        }
        
        private func constructLogo() {
            
            iv_logo = TSImageView()
            iv_logo.image = imageProvider.getLogo()
            
        }
        
        private func constructHeading() {
            
            tv_heading = TSTextView()
            tv_heading.text = onHeading()
            tv_heading.textColor = UIColor.white
            tv_heading.font = fontProvider.getSemiboldLargest()
            tv_heading.textAlignment = .left
            
        }
        
        private func constructInfo() {
            
            tv_info = TSTextView()
            tv_info.text = onInfo()
            tv_info.textColor = UIColor.white
            tv_info.font = fontProvider.getRegularSmall()
            
        }
        
        private func constrainBackground(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainBackButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_back, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: iv_back, attribute: .centerY, relatedBy: .equal, toItem: iv_logo, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_back, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_back, attribute: .height, relatedBy: .equal, toItem: iv_back, attribute: .width, multiplier: 1, constant: 0))
            
        }
        
        private func constrainLogo(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.35, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .height, relatedBy: .equal, toItem: iv_logo, attribute: .width, multiplier: imageProvider.getLogoReverseRatio(), constant: 0))
            
        }
        
        private func constrainHeading(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .top, relatedBy: .equal, toItem: iv_back, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -50))
            set.append(NSLayoutConstraint(item: tv_heading, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
            
        }
        
        private func constrainInfo(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_info, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_info, attribute: .top, relatedBy: .equal, toItem: tv_heading, attribute: .bottom, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: tv_info, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -50))
            set.append(NSLayoutConstraint(item: tv_info, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30))
            
        }
        
        open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.endEditing(true)
        }
        
    }

}
