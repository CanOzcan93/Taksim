//
//  CoordinateSelectionLayout-Main.swift
//  Taksim
//
//  Created by Can Özcan on 25.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import GooglePlaces
import GoogleMaps

extension Main {
    
    public class CoordinateSelectionLayout: TSLayout, UISearchBarDelegate {
        
        public var mv: TSMapView!
        private var iv_marker: TSImageView!
        public var ti_results: PostLogin.TextInput!
        private var location: CoreCoordinate!
        public var button: PostLogin.TallButton!
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.mv = TSMapView(layout: self as TSLayout, initialCoordinate: CoreCoordinate(latitude: 41.116910000000004, longitude: 29.01432), initialZoom: 14)
            self.mv.onMapDragged = { (position) in
                
                let gms = GMSGeocoder()
                gms.reverseGeocodeCoordinate(position.target) { (response, error) in
                    
                    if let responseStraight = response {
                        
                        self.location = CoreCoordinate(latitude: position.target.latitude, longitude: position.target.longitude)
                        let addressText = responseStraight.firstResult()?.lines?.first
                        
                        self.ti_results.text = addressText!
                        
                        self.button.isUserInteractionEnabled = true
                        
                    }
                    
                }
            }
            
            self.iv_marker = TSImageView()
            self.iv_marker.image = imageProvider.getMarkerIcon()
            self.addSubview(iv_marker)
            
            self.button = PostLogin.TallButton()
            self.button.setTitle("Tamam", for: .normal)
            self.button.isUserInteractionEnabled = false
            self.addSubview(button)
            
            self.ti_results = PostLogin.TextInput()
            self.ti_results.isUserInteractionEnabled = false
            self.ti_results.font = fontProvider.getRegularSmall()
            self.addSubview(ti_results)
            
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: iv_marker, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_marker, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_marker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40))
            set.append(NSLayoutConstraint(item: iv_marker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
            
            set.append(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -40))
            
            set.append(NSLayoutConstraint(item: ti_results, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 40))
            set.append(NSLayoutConstraint(item: ti_results, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: ti_results, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))

            
        }
        
    }
    
}
