//
//  OrdersList.swift
//  Taksim
//
//  Created by Can Özcan on 18.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Profile {
    
    public class OrderList: TSListView<OrderListItem> {
        
        public override func onInit() {
            self.backgroundColor = .clear
        }
        
    }
    
}
