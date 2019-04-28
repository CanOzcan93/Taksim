//
//  OrderHistoryLayout.swift
//  Taksim
//
//  Created by Can Özcan on 18.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class OrderHistoryLayout: PostLogin.WavyLayout {
        
        private var lv: OrderList!
        
        public override func onHeading() -> String {
            return lexiconProvider.get("trips")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            let items = [
                OrderListItem(),
                OrderListItem(),
                OrderListItem(),
                OrderListItem()
            ]
            
            self.lv = OrderList(items: items)
            
            self.addSubview(self.lv)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: lv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -95))
            set.append(NSLayoutConstraint(item: lv, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
        }
        
    }
    
}
