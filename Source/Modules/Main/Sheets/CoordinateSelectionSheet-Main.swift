//
//  CoordinateSelectionSheet-Main.swift
//  Taksim
//
//  Created by Can Özcan on 25.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import GooglePlaces
import GoogleMaps

extension Main {
    
    public class CoordinateSelectionSheet : Sheet<CoordinateSelectionLayout> {
        
        public override func onLayoutAppear(layout: Main.CoordinateSelectionLayout) {
            
            let place = exchangeFlow.grabLastSelectedPlace()!.coordinate
            let coordinate = CoreCoordinate(latitude: place.latitude, longitude: place.longitude)
            layout.mv.dragTo(coordinate: coordinate)
            
        }
        
        public override func onLayoutReady(layout: Main.CoordinateSelectionLayout) {
            
            layout.button.onClick {
                
                let centerCoordinate = layout.mv.pickCenter()
                let centerAddress = layout.ti_results.text!
                
                if (self.stateMachine.editingPickUpPoint()) {
                    
                    self.exchangeFlow.letPickUpPointCoordinate(coordinate: centerCoordinate)
                    self.exchangeFlow.letPickUpPointAddress(address: centerAddress)
                    
                    self.stateMachine.isPickUpPointSelected(state: true)
                    
                }
                
                if (self.stateMachine.editingDestinationPoint()) {
                    
                    self.exchangeFlow.letDestinationCoordinate(coordinate: centerCoordinate)
                    self.exchangeFlow.letDestinationAddress(address: centerAddress)
                    
                    self.stateMachine.isDestinationPointSelected(state: true)
                    
                }
                
                self.eventManager.shout(key: "updateRouteLocation")
                
                self.demonstrator.goBackFromCoordinateSelectionToMainSheet()
                
            }
            
            layout.ti_results.onTap {
                self.demonstrator.goBackFromCoordinateSelectionToAutoComplete()
            }
            
        }
        
    }
    
}
