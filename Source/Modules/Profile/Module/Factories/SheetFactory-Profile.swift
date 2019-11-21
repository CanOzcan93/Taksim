//
//  SheetFactory-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class SheetFactory: CoreSheetFactory {
        
        private var main: MainSheet?
        public func getMainSheet() -> MainSheet {
            
            guard main != nil else {
                main = MainSheet()
                return main!
            }
            
            return main!
            
        }
        
        private var notifications: NotificationsSheet?
        public func getNotificationsSheet() -> NotificationsSheet {
            
            guard notifications != nil else {
                notifications = NotificationsSheet()
                return notifications!
            }
            
            return notifications!
            
        }
        
        private var orderHistory: OrderHistorySheet?
        public func getOrderHistorySheet() -> OrderHistorySheet {
            guard orderHistory != nil else {
                orderHistory = OrderHistorySheet()
                return orderHistory!
            }
            
            return orderHistory!
        }
        
        private var photoShoot: PhotoShootSheet?
        public func getPhotoShootSheet() -> PhotoShootSheet {
            guard photoShoot != nil else {
                photoShoot = PhotoShootSheet()
                return photoShoot!
            }
            
            return photoShoot!
        }
        
        private var address: AddressSheet?
        public func getAddressSheet() -> AddressSheet {
            guard address != nil else {
                address = AddressSheet()
                return address!
            }
            
            return address!
        }
        
        private var creditCards: CreditCardsSheet?
        public func getCreditCardsSheet() -> CreditCardsSheet {
            guard creditCards != nil else {
                creditCards = CreditCardsSheet()
                return creditCards!
            }
            
            return creditCards!
        }
        
        private var addCards: AddCardSheet?
        public func getAddCardSheet() -> AddCardSheet {
            guard addCards != nil else {
                addCards = AddCardSheet()
                return addCards!
            }
            
            return addCards!
        }
        
        private var cardWeb: CardWebSheet?
        public func getWebCardSheet() -> CardWebSheet {
            cardWeb = CardWebSheet()
            return cardWeb!
            
        }

        
    }
    
}
