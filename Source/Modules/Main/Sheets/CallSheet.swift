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
            
            self.stateMachine.isCallSheetAppear(state: true)
            
            layout.addDriverInfo(driver: self.dataStorage.grabDispatchedDriver()!, vehicle: self.dataStorage.grabDispatchedVehicle()!)
            
            layout.onHangUp = {
                self.demonstrator.goBackFromCallSheetToTripToPickUpPointSheet()
            }
            
            
        }
        
        public override func onLayoutReappear(layout: Main.CallLayout) {
            self.stateMachine.isCallSheetAppear(state: true)
        }
        
    }
    
}
