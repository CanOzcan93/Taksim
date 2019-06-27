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
        public var st_overlay: StatusOrderOverlay!
        public var pay_overlay: OrderPaymentOverlay!
        private var initialized: Bool = false
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.mv = TSMapView(layout: self, initialCoordinate: CoreCoordinate(latitude: 38.4291513, longitude: 27.139717), initialZoom: 14)
            self.mv.trackDeviceLocation()
            self.mv.transitive.settings.setAllGesturesEnabled(false)
            
            self.st_overlay = StatusOrderOverlay(layout: self)
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.st_overlay.show()
            }
            self.pay_overlay = OrderPaymentOverlay(layout: self)
            
        }
        
    }
    
}
