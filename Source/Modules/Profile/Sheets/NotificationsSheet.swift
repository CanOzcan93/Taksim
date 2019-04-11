//
//  NotificationsSheet.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Profile {
    
    public class NotificationsSheet: Sheet<NotificationsLayout> {
        
        public override func onLayoutReady(layout: Profile.NotificationsLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
