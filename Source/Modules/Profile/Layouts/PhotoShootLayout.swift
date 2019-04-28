//
//  PhotoShootLayout.swift
//  Taksim
//
//  Created by Can Özcan on 19.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class PhotoShootLayout: TSLayout {
        
//        public var onBackButtonClicked: Action?
        
        public var iv_back: TSImageView!
        public var v_camera: TSView!
        public var iv_shoot: TSImageView!
        public var iv_turn: TSImageView!
        
        private var iv_logo: TSImageView!
        
        public override func onConstruct() {
            
            super.onConstruct()
            self.backgroundColor = colorProvider.getBlackFull()
            constructImageBack()
            constructImageLogo()
            constructViewCamera()
            constructImageShoot()
            constructImageTurn()
            
        }
        
        private func constructImageBack() {
            iv_back = TSImageView()
            iv_back.image = imageProvider.getBackGrayIcon()
            self.addSubview(iv_back)
        }
        
        private func constructImageLogo() {
            iv_logo = TSImageView()
            iv_logo.image = imageProvider.getLogo()
            self.addSubview(iv_logo)
        }
        
        private func constructViewCamera() {
            v_camera = TSView()
            v_camera.backgroundColor = colorProvider.getWhiteFull()
            self.addSubview(v_camera)
        }
        
        private func constructImageShoot() {
            iv_shoot = TSImageView()
            iv_shoot.image = imageProvider.getCameraIcon()
            self.addSubview(iv_shoot)
        }
        
        private func constructImageTurn() {
            iv_turn = TSImageView()
            iv_turn.image = imageProvider.getTurnCameraIcon()
            self.addSubview(iv_turn)

        }
        
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            constrainImageBack(set: &set)
            constrainImageLogo(set: &set)
            constrainViewCamera(set: &set)
            constrainImageShoot(set: &set)
            constrainImageTurn(set: &set)
            
        }
        
        private func constrainImageBack(set: inout [NSLayoutConstraint]) {
            set.append(NSLayoutConstraint(item: iv_back, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_back, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: iv_back, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
            set.append(NSLayoutConstraint(item: iv_back, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
        }
        
        private func constrainImageLogo(set: inout [NSLayoutConstraint]) {
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .height, relatedBy: .equal, toItem: iv_logo, attribute: .width, multiplier: imageProvider.getLogoReverseRatio(), constant: 0))
        }
        
        private func constrainViewCamera(set: inout [NSLayoutConstraint]) {
            set.append(NSLayoutConstraint(item: v_camera, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_camera, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.9, constant: 0))
            set.append(NSLayoutConstraint(item: v_camera, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_camera, attribute: .height, relatedBy: .equal, toItem: v_camera, attribute: .width, multiplier: 1, constant: 0))
        }
        
        private func constrainImageShoot(set: inout [NSLayoutConstraint]) {
            set.append(NSLayoutConstraint(item: iv_shoot, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_shoot, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: iv_shoot, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 80))
            set.append(NSLayoutConstraint(item: iv_shoot, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 80))
        }
        
        private func constrainImageTurn(set: inout [NSLayoutConstraint]) {
            set.append(NSLayoutConstraint(item: iv_turn, attribute: .centerY, relatedBy: .equal, toItem: iv_shoot, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_turn, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: iv_turn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
            set.append(NSLayoutConstraint(item: iv_turn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
        }
        
    }
    
}
