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
        
    }
    
}
