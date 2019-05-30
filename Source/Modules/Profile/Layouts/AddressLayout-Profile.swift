//
//  AdressLayout-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 22.05.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class AddressLayout: PostLogin.WavyLayout {
        
        private var tv_soon: TSTextView!
        
        public override func onHeading() -> String {
            return "Adreslerim"
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.tv_soon = TSTextView()
            self.tv_soon.textAlignment = .center
            self.tv_soon.font = fontProvider.getSemiboldLargest()
            self.tv_soon.text = "Yakında Eklenecektir"
            
            self.addSubview(self.tv_soon)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -95))
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
        }
        
    }
    
}
