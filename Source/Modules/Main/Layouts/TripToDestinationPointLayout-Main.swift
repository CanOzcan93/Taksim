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
        public var btn_curLoc: TSButton!

        private var initialized: Bool = false
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.mv = TSMapView(layout: self, initialCoordinate: CoreCoordinate(latitude: 38.4291513, longitude: 27.139717), initialZoom: 14)
//            self.mv.transitive.settings.setAllGesturesEnabled(false)
            
            self.st_overlay = StatusOrderOverlay(layout: self)
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.st_overlay.show()
            }
            self.pay_overlay = OrderPaymentOverlay(layout: self)
            
            self.btn_curLoc = TSButton()
            self.btn_curLoc.setImage(imageProvider.getCurrentLocationIcon(), for: .normal)
            self.btn_curLoc.backgroundColor = .clear
            self.btn_curLoc.onDraw = { rect in
                self.btn_curLoc.layer.cornerRadius = rect.size.width/2
                self.btn_curLoc.clipsToBounds = true
            }
            self.addSubview(btn_curLoc)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 100))
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        }
        
    }
    
}
