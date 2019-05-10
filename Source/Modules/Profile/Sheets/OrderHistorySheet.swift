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
            
            var items = [OrderListItem]()
            
            apiManager.customerHistoryOrders(
                mobile: self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) as! String,
                page: 1,
                num: 1,
                token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) { response in
                    
                    if response["errCode"].exists() && response["errCode"].uIntValue == 0 {
                        for orderJson in response["orders"].arrayValue {
                            let item = OrderListItem()
                            item.changeLabels(
                                name: orderJson["driverName"].string,
                                no: orderJson["carNo"].string,
                                date: orderJson["createdTime"].string,
                                price: orderJson["orderPrice"].doubleValue
                            )
                            items.append(item)
                        }
                        layout.lv.addItems(items)
                    }
                
            }
            
            
        }
        
    }
}
