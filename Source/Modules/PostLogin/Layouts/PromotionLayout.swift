//
//  PromotionLayout.swift
//  Taksim
//
//  Created by Can Özcan on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class PromotionLayout: WavyLayout {
        
        private var tv: TextView!
        
        private var ti: TextInput!
        private var btn: Button!
        
        public override func onHeading() -> String {
            return lexiconProvider.get("promotion")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.tv = TextView()
            self.tv.font = fontProvider.getRegularSmall()
            self.tv.lineBreakMode = .byWordWrapping
            self.tv.numberOfLines = 0
            self.tv.textAlignment = .center
            self.tv.text = "Bir indirim koduna mı sahipsiniz? Kodu aşağıdaki alana girin ve indiriminizi alın."
            
            self.addSubview(self.tv)
            
            
            self.ti = TextInput()
            self.ti.setPlaceholder(text: "Promosyon Kodu")
            
            self.addSubview(self.ti)
            
            
            self.btn = Button()
            self.btn.setTitle("Gönder", for: .normal)
            
            self.addSubview(self.btn)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -60))
            set.append(NSLayoutConstraint(item: tv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 120))
            
            set.append(NSLayoutConstraint(item: ti, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -60))
            set.append(NSLayoutConstraint(item: ti, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .top, relatedBy: .equal, toItem: tv, attribute: .bottom, multiplier: 1, constant: 20))
            
            set.append(NSLayoutConstraint(item: btn, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: 0))
            set.append(NSLayoutConstraint(item: btn, attribute: .top, relatedBy: .equal, toItem: ti, attribute: .bottom, multiplier: 1, constant: 20))
            
        }
        
    }
    
}
