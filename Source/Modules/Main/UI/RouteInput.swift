//
//  RouteGroup.swift
//  Taksim
//
//  Created by Can Özcan on 25.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core
import GooglePlaces
import GoogleMaps

extension Main {
    
    public class RouteInput: TSCompoundView {
        
        // Internal Fields
        
        private var v_background: TSView!
        private var ti_pickUp: TextInput!
        private var v_line: TSView!
        private var ti_destination: TextInput!
        private var iv_from: TSImageView!
        private var iv_dots: TSImageView!
        private var iv_to: TSImageView!
        
        // API
        
        public var onPickUpPointEditing: Action?
        public var onDestinationPointEditing: Action?
        
        
        // Implementation
        
        public override func onConstruct(layout: CoreLayout) {
            
            constructBackgroundView()
            constructFromTextInput()
            constructLineView()
            constructToTextInput()
            constructFromIcon()
            constructDotsIcon()
            constructToIcon()
            
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            constrainBackgroundView(set: &set, layout: layout)
            constrainFromTextInput(set: &set, layout: layout)
            constrainLineView(set: &set, layout: layout)
            constrainToTextInput(set: &set, layout: layout)
            constrainFromIcon(set: &set, layout: layout)
            constrainDotsIcon(set: &set, layout: layout)
            constrainToIcon(set: &set, layout: layout)
            
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
        
        private func constructFromTextInput() {
            
            self.ti_pickUp = TextInput()
            self.ti_pickUp.tag = 0
            self.ti_pickUp.setPlaceholder(text: lexiconProvider.get("current_location"))
            self.ti_pickUp.onTap {
                self.ti_pickUp.endEditing(true)
                self.onPickUpPointEditing?()
            }
            self.packView(self.ti_pickUp)
            
        }
        
        private func constructLineView() {
            
            self.v_line = TSView()
            self.v_line.backgroundColor = colorProvider.getGrayLight()
            
            self.packView(self.v_line)
            
        }
        
        private func constructToTextInput() {
            
            self.ti_destination = TextInput()
            self.ti_destination.tag = 1
            self.ti_destination.setPlaceholder(text: lexiconProvider.get("destination_location"))
            self.ti_destination.onTap {
                self.ti_destination.endEditing(true)
                self.onDestinationPointEditing?()
            }
            self.packView(self.ti_destination)
            
        }
        
        private func constructFromIcon() {
            
            self.iv_from = TSImageView()
            self.iv_from.image = imageProvider.getBullsEye()
            
            self.packView(self.iv_from)
            
        }
        
        private func constructDotsIcon() {
            
            self.iv_dots = TSImageView()
            self.iv_dots.image = imageProvider.getVerticalDots()
            
            self.packView(self.iv_dots)
            
        }
        
        private func constructToIcon() {
            
            self.iv_to = TSImageView()
            self.iv_to.image = imageProvider.getLocation()
            
            self.packView(self.iv_to)
            
        }
        
        private func constrainBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_background, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .top, multiplier: 1, constant: 75))
            set.append(NSLayoutConstraint(item: v_background, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: v_background, attribute: .right, relatedBy: .equal, toItem: layout, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 85))
            
        }
        
        private func constrainFromTextInput(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: ti_pickUp, attribute: .top, relatedBy: .equal, toItem: v_background, attribute: .top, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: ti_pickUp, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_pickUp, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 40))
            
        }
        
        private func constrainLineView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_line, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line, attribute: .width, relatedBy: .equal, toItem: v_background, attribute: .width, multiplier: 1, constant: -35))
            set.append(NSLayoutConstraint(item: v_line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
            
        }
        
        private func constrainToTextInput(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: ti_destination, attribute: .bottom, relatedBy: .equal, toItem: v_background, attribute: .bottom, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: ti_destination, attribute: .right, relatedBy: .equal, toItem: v_background, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_destination, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 40))
            
        }
        
        private func constrainFromIcon(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: iv_from, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: iv_from, attribute: .centerY, relatedBy: .equal, toItem: ti_pickUp, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_from, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 12))
            set.append(NSLayoutConstraint(item: iv_from, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 12))
            
        }
        
        private func constrainDotsIcon(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 17.5))
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .centerY, relatedBy: .equal, toItem: v_background, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 2))
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 14))
            
        }
        
        private func constrainToIcon(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: iv_to, attribute: .left, relatedBy: .equal, toItem: v_background, attribute: .left, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: iv_to, attribute: .centerY, relatedBy: .equal, toItem: ti_destination, attribute: .centerY, multiplier: 1, constant: -2.5))
            set.append(NSLayoutConstraint(item: iv_to, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 12))
            set.append(NSLayoutConstraint(item: iv_to, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 16.5))
            
        }
        
        public func setPickUpAddress(address: String) {
            self.ti_pickUp.text = address
        }
        
        public func setDestinationAddress(address: String) {
            self.ti_destination.text = address
        }
        
        
    }
}
