//
//  TripToDestinationPointLayout-Main.swift
//  Taksim
//
//  Created by Can Özcan on 5.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation
import Core

extension Main {
    
    public class TripToDestinationPointLayout: TSLayout {
        
        public var mv: TSMapView!
        
        public override func onConstruct() {
            
            self.mv = TSMapView(layout: self, initialCoordinate: CoreCoordinate(latitude: 38.4291513, longitude: 27.139717), initialZoom: 14)
            self.mv.trackDeviceLocation()
            self.mv.transitive.settings.setAllGesturesEnabled(false)
            
        }
        
    }
    
}
