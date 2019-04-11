//
//  CallSheet.swift
//  Taksim
//
//  Created by E.E.E. on 31.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import AVFoundation

extension Main {
    
    public class CallSheet: Sheet<CallLayout> {
        
        
        public override func onLayoutReady(layout: Main.CallLayout) {
            
            layout.onHangUp = {
                self.demonstrator.goBackFromCallSheetToTripToPickUpPointSheet()
            }
            
            
        }
        
    }
    
}
