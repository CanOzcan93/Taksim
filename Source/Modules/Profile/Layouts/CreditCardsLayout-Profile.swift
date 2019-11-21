//
//  CreditCardsLayout-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 22.05.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class CreditCardsLayout: PostLogin.WavyLayout {
        
        public var lv: CreditCardList!
        
        public override func onHeading() -> String {
            return "Kredi Kartlarım"
        }
        
        public override func addButton() -> Bool {
            return true
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.lv = CreditCardList(items: [CreditCardListItem()])
            
            self.addSubview(self.lv)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: lv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: lv, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 105))
            set.append(NSLayoutConstraint(item: lv, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -105))
            set.append(NSLayoutConstraint(item: lv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
        }
        
    }
    
}
