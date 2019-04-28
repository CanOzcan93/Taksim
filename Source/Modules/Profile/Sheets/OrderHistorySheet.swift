//
//  OrderHistorySheet.swift
//  Taksim
//
//  Created by Can Özcan on 18.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Profile {
    
    public class OrderHistorySheet: Sheet<OrderHistoryLayout> {
        
        public override func onLayoutReady(layout: Profile.OrderHistoryLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
