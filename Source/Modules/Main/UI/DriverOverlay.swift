//
//  DriverOverlay.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class DriverOverlay: TSCompoundView {

        
        // Packed Views
        
        private var v_background: TSView!
        
        private var iv_avatar: TSImageView!
        
        private var tv_name: PostLogin.TextView!
        private var tv_plate: PostLogin.TextView!
        private var tv_vehicle: PostLogin.TextView!
        private var tv_duration: PostLogin.TextView!
        
        private var iv_phone: TSImageView!
        
        private var iv_cross: TSImageView!
        
        
        // Fields
        
        public var onCall: Action?
        public var onCancel: Action?
        
        
        // Internal Fields
        
        private var hiddenConstraint: NSLayoutConstraint!
        private var visibleConstraint: NSLayoutConstraint!
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructBackgroundView()
            
            constructAvatarIcon()
            
            constructNameTextView()
            constructPlateTextView()
            constructVehicleTextView()
            constructDurationTextView()
            
            constructPhoneIcon()
            
            constructCrossIcon()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainBackgroundView(set: &set, layout: layout)
            
            constrainAvatarIcon(set: &set)
            
            constrainNameTextView(set: &set)
            constrainPlateTextView(set: &set)
            constrainVehicleTextView(set: &set)
            constrainDurationTextView(set: &set)
            
            constrainPhoneIcon(set: &set)
            
            constrainCrossIcon(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructBackgroundView() {
            
            self.v_background = TSView()
            self.v_background.isOpaque = false
            self.v_background.onDraw = { rect in
                
                self.v_background.layer.sublayers?.removeAll()
                
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 6).cgPath
                let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)), cornerRadius: 8).cgPath
                
                let layer = CAShapeLayer()
                layer.path = path
                layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                
                layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                layer.shadowPath = shadowPath
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0.2
                layer.shadowRadius = 8
                
                self.v_background.layer.insertSublayer(layer, at: 0)
                
            }
            
            self.packView(self.v_background)
            
        }
        
        private func constructAvatarIcon() {
            
            self.iv_avatar = TSImageView()
            self.iv_avatar.image = imageProvider.getAvatar()
            
            self.packView(self.iv_avatar)
            
        }
        
        private func constructNameTextView() {
            
            self.tv_name = PostLogin.TextView()
            self.tv_name.text = "Tahsin D."
            self.tv_name.font = fontProvider.getSemiboldMedium()
            
            self.packView(self.tv_name)
            
        }
        
        private func constructPlateTextView() {
            
            self.tv_plate = PostLogin.TextView()
            self.tv_plate.text = "34 FC 1876"
            self.tv_plate.font = fontProvider.getRegularSmall()
            
            self.packView(self.tv_plate)
            
        }
        
        private func constructVehicleTextView() {
            
            self.tv_vehicle = PostLogin.TextView()
            self.tv_vehicle.text = "Volkswagen Passat"
            self.tv_vehicle.font = fontProvider.getRegularSmall()
            
            self.packView(self.tv_vehicle)
            
        }
        
        private func constructDurationTextView() {
            
            self.tv_duration = PostLogin.TextView()
            self.tv_duration.text = lexiconProvider.get("estimated_time")+": 20 dk"
            self.tv_duration.font = fontProvider.getRegularSmall()
            
            self.packView(self.tv_duration)
            
        }
        
        private func constructPhoneIcon() {
            
            self.iv_phone = TSImageView()
            self.iv_phone.image = imageProvider.getPhone()
            self.iv_phone.onTap {
                self.onCall?()
            }
            
            self.packView(self.iv_phone)
            
        }
        
        private func constructCrossIcon() {
            
            self.iv_cross = TSImageView()
            self.iv_cross.image = imageProvider.getFilledCross()
            self.iv_cross.onTap {
                self.onCancel?()
            }
            
            self.packView(self.iv_cross)
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            self.hiddenConstraint = NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 20)
            self.visibleConstraint = NSLayoutConstraint(item: v_background, attribute: .bottom, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
            
            set.append(hiddenConstraint)
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140))
            
        }
        
        private func constrainAvatarIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
            
        }
        
        private func constrainNameTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_name, attribute: .left, relatedBy: .equal, toItem: iv_avatar, attribute: .right, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .top, multiplier: 1, constant: 25))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .right, relatedBy: .equal, toItem: iv_phone, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
            
        }
        
        private func constrainPlateTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .left, relatedBy: .equal, toItem: iv_avatar, attribute: .right, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .top, relatedBy: .equal, toItem: tv_name, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .right, relatedBy: .equal, toItem: iv_phone, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainVehicleTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_vehicle, attribute: .left, relatedBy: .equal, toItem: iv_avatar, attribute: .right, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: tv_vehicle, attribute: .top, relatedBy: .equal, toItem: tv_plate, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_vehicle, attribute: .right, relatedBy: .equal, toItem: iv_phone, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_vehicle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainDurationTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_duration, attribute: .left, relatedBy: .equal, toItem: iv_avatar, attribute: .right, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: tv_duration, attribute: .top, relatedBy: .equal, toItem: tv_vehicle, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_duration, attribute: .right, relatedBy: .equal, toItem: iv_phone, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_duration, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainPhoneIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_phone, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: iv_phone, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_phone, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
            set.append(NSLayoutConstraint(item: iv_phone, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
            
        }
        
        private func constrainCrossIcon(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_cross, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: iv_cross, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .top, multiplier: 1, constant: -15))
            set.append(NSLayoutConstraint(item: iv_cross, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35))
            set.append(NSLayoutConstraint(item: iv_cross, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35))
            
        }
        
        
        // Methods
        
        public func show() {
            
            self.shift(from: hiddenConstraint, to: visibleConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        public func hide() {
            
            self.shift(from: visibleConstraint, to: hiddenConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        public func setDuration(duration: Int) {
            self.tv_duration.text = lexiconProvider.get("estimated_time") + ": \(duration/60) dk"
        }
        
        public func setDriverInfo(driver: Driver, vehicle: Vehicle) {
            if (driver.driverName != nil && driver.driverName! != "") {
                self.tv_name.text = driver.driverName
            }
            if (vehicle.model != nil && vehicle.model! != "") {
                self.tv_plate.text = vehicle.model
            }
            if (vehicle.no != "") {
                self.tv_vehicle.text = vehicle.no
            }
            if (driver.image != nil) {
                let imager = driver.image?.scaleImageToFitSize(size: CGSize(width: 60, height: 60))
                self.iv_avatar.image  = imager?.roundedImage
            }
        }
        
    }

}
