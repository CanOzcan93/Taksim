//
//  TutorialSliderItem-Authentication.swift
//  Taksim
//
//  Created by Can Özcan on 22.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation
import Core

extension Authentication {
    
    public class TutorialSliderItem: TSSliderItem {
        
        var imageView: TSImageView!
        var titleTextView: TSTextView!
        var bodyTextView: TSTextView!
        
        public required init(image: UIImage, title: String, body: String) {
            
            self.imageView = TSImageView()
            self.imageView.image = image
            
            titleTextView = TSTextView()
            titleTextView.text = title
            titleTextView.numberOfLines = 2
            titleTextView.textAlignment = .center
            
            bodyTextView = TSTextView()
            bodyTextView.text = body
            bodyTextView.numberOfLines = 0
            bodyTextView.textAlignment = .center
            
            super.init()
        }
        
        required init() {
            super.init()
        }
        
        required init?(coder decoder: NSCoder) {
            super.init(coder: decoder)
        }
        
        open override func onConstruct() {
            super.onConstruct()
            self.backgroundColor = UIColor.clear
            self.isOpaque = false
            self.onDraw = { (rect) in
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 4).cgPath
                let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)), cornerRadius: 8).cgPath
                
                let layer = CAShapeLayer()
                layer.path = path
                layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                
                layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                layer.shadowPath = shadowPath
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0.2
                layer.shadowRadius = 8
                
                self.layer.insertSublayer(layer, at: 0)
            }
            
            titleTextView.font = fontProvider.getSemiboldMid()
            bodyTextView.font = fontProvider.getRegularMedium()
            
            self.addSubview(imageView)
            self.addSubview(titleTextView)
            self.addSubview(bodyTextView)
        }
        
        open override func onConstrain() {
            super.onConstrain()
            
            self.constrain(constraint: NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.constrain(constraint: NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 60))
            self.constrain(constraint: NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 175))
            self.constrain(constraint: NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 150))
            
            self.constrain(constraint: NSLayoutConstraint(item: titleTextView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.constrain(constraint: NSLayoutConstraint(item: titleTextView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 20))
            self.constrain(constraint: NSLayoutConstraint(item: titleTextView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -20))
            self.constrain(constraint: NSLayoutConstraint(item: titleTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
            
            self.constrain(constraint: NSLayoutConstraint(item: bodyTextView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.constrain(constraint: NSLayoutConstraint(item: bodyTextView, attribute: .top, relatedBy: .equal, toItem: titleTextView, attribute: .bottom, multiplier: 1, constant: 15))
            self.constrain(constraint: NSLayoutConstraint(item: bodyTextView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -20))
            self.constrain(constraint: NSLayoutConstraint(item: bodyTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 80))
            
        }
        
    }
    
}
