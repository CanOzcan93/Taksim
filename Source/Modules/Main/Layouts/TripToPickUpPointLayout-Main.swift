//
//  TripToPickUpPoint-Main.swift
//  Taksim
//
//  Created by Can Özcan on 30.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation
import Core

extension Main {
    
    public class TripToPickUpPointLayout: TSLayout {
        
        public var mv: TSMapView!
        public var o_driver: DriverOverlay!
        
        public override func onConstruct() {
            
            self.mv = TSMapView(layout: self, initialCoordinate: CoreCoordinate(latitude: 38.4291513, longitude: 27.139717), initialZoom: 14)
            self.mv.trackDeviceLocation()
//            self.mv.transitive.settings.setAllGesturesEnabled(false)
            
            self.o_driver = DriverOverlay(layout: self)
            
        }
        
    }
    
}
