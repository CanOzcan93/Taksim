//
//  CreditCardList.swift
//  Taksim
//
//  Created by Can Özcan on 14.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Profile {
    
    public class CreditCardList: TSListView<CreditCardListItem> {
        
        public override func onInit() {
            self.backgroundColor = .clear
            self.isOpaque = false
        }
        
        public override func needSeparator() -> Bool {
            return true
        }
        
        public override func emptyMessage() -> String {
            return "Şu anda görüntülenebilen herhangi bir kredi kartı bulunmamaktadır. Kart eklemek için yukarıdaki + tuşuna basabilirsiniz."
        }
        
    }
    
}
