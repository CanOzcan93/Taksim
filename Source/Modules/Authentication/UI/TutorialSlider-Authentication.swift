//
//  TutorialSlider-Authentication.swift
//  Taksim
//
//  Created by Can Özcan on 22.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import Foundation

extension Authentication {
    
    public class TutorialSlider: TSSlider<TutorialSliderItem, TutorialPageControl, OnboardingLayout> {
        
        public override func onConstrain() {
            super.onConstrain()
            
            for i in 0..<self.items.count {
                if i == 0 {
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 300))
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
                }
                else {
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .left, relatedBy: .equal, toItem: self.items[i-1], attribute: .right, multiplier: 1, constant:CGFloat(self.spacePages)))
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .centerY, relatedBy: .equal, toItem: self.items[i-1], attribute: .centerY, multiplier: 1, constant: 0))
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .width, relatedBy: .equal, toItem: self.items[i-1], attribute: .width, multiplier: 1, constant: 0))
                    self.constrain(constraint: NSLayoutConstraint(item: self.items[i], attribute: .height, relatedBy: .equal, toItem: self.items[i-1], attribute: .height, multiplier: 1, constant: 0))
                }
                
            }
            
            self.layout.constrain(constraint: NSLayoutConstraint(item: self.pageControl, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.layout.constrain(constraint: NSLayoutConstraint(item: self.pageControl, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 40))
            self.layout.constrain(constraint: NSLayoutConstraint(item: self.pageControl, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.2, constant: 0))
            self.layout.constrain(constraint: NSLayoutConstraint(item: self.pageControl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
        }
        
    }
    
}
