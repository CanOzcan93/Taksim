//
//  AdressSheet-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 22.05.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation

extension Profile {
    
    public class AddressSheet: Sheet<AddressLayout> {
        
        public override func onLayoutReady(layout: Profile.AddressLayout) {
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
        }
        
    }
}
