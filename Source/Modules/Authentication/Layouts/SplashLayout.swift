//
//  SplashLayout.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Authentication {
    
    public class SplashLayout: TSLayout {
        
        public var iv_background: TSImageView!
        
        public var iv_logo: TSImageView!
        public var iv_logoIzmir: TSImageView!
        public var iv_logoIso: TSImageView!
        
        public override func onConstruct() {
            
            constructBackgroundImage()
            constructLogo()
            constructLogoIzmir()
            constructLogoIso()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            constrainBackground(set: &set)
            constrainLogo(set: &set)
            constrainLogoIzmir(set: &set)
            constrainLogoIso(set: &set)
        }
        
        private func constructBackgroundImage() {
            
            iv_background = TSImageView()
            iv_background.image = imageProvider.getBackgroundImage()
            
            self.addSubview(iv_background)
            
        }
        
        private func constructLogo() {
            
            iv_logo = TSImageView()
            iv_logo.image = imageProvider.getLogo()
            
            self.addSubview(iv_logo)
            
        }
        
        private func constructLogoIzmir() {
            
            iv_logoIzmir = TSImageView()
            iv_logoIzmir.image = imageProvider.getLogoIzmir()
            
            self.addSubview(iv_logoIzmir)
            
        }
        
        private func constructLogoIso() {
            
            iv_logoIso = TSImageView()
            iv_logoIso.image = imageProvider.getLogoIso()
            
            self.addSubview(iv_logoIso)
            
        }
        
        private func constrainBackground(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_background, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainLogo(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.75, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .height, relatedBy: .equal, toItem: iv_logo, attribute: .width, multiplier: imageProvider.getLogoReverseRatio(), constant: 0))
            
        }
        
        private func constrainLogoIzmir(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_logoIzmir, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logoIzmir, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: iv_logoIzmir, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.17, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logoIzmir, attribute: .height, relatedBy: .equal, toItem: iv_logoIzmir, attribute: .width, multiplier: 1.1, constant: 0))
            
        }
        
        private func constrainLogoIso(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_logoIso, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.4, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logoIso, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: iv_logoIso, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.15, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logoIso, attribute: .height, relatedBy: .equal, toItem: iv_logoIso, attribute: .width, multiplier: 1.2, constant: 0))
            
        }
        
    }
    
}
