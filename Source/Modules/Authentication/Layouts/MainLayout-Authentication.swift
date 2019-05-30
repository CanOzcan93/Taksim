//
//  AuthenticationLayout.swift
//  Authentication
//
//  Created by Can Özcan on 12.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import UIKit

extension Authentication {

    public class MainLayout: TSLayout {
        
        
        // Fields
        
        public var cover: TSImageView!
        public var logo: TSImageView!
        public var btnSignUp: Button!
        public var btnLogin: OutlinedButton!
        
        
        // Implementation
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            constructCover()
            constructLogo()
            constructSignUpButton()
            constructLoginButton()
            
            self.addSubview(cover)
            self.addSubview(logo)
            self.addSubview(btnSignUp)
            self.addSubview(btnLogin)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            constrainBackground(set: &set)
            constrainLogo(set: &set)
            constrainSignUpButton(set: &set)
            constrainLoginButton(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructCover() {
            
            cover = TSImageView()
            cover.image = imageProvider.getCoverImage()
            
        }
        
        private func constructLogo() {
            
            logo = TSImageView()
            logo.image = imageProvider.getLogo()
            
        }
        
        private func constructSignUpButton() {
            
            btnSignUp = Button()
            btnSignUp.setTitle(lexiconProvider.get("signup"), for: .normal)
            
        }
        
        private func constructLoginButton() {
            
            btnLogin = OutlinedButton()
            btnLogin.setTitle(lexiconProvider.get("login"), for: .normal)
            
        }
        
        private func constrainBackground(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: cover, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: cover, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: cover, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: cover, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainLogo(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: logo, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 50))
            set.append(NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))
            set.append(NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: logo, attribute: .width, multiplier: imageProvider.getLogoReverseRatio(), constant: 0))
            
        }
        
        private func constrainSignUpButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btnSignUp, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5, constant: 5))
            set.append(NSLayoutConstraint(item: btnSignUp, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -50))
            set.append(NSLayoutConstraint(item: btnSignUp, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.45, constant: 0))
            
        }
        
        private func constrainLoginButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btnLogin, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: -5))
            set.append(NSLayoutConstraint(item: btnLogin, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -50))
            set.append(NSLayoutConstraint(item: btnLogin, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.45, constant: 0))
            
        }
        
    }

}
