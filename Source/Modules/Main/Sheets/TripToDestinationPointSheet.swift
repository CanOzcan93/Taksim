//
//  TripToDestinationPointSheet.swift
//  Taksim
//
//  Created by Can Özcan on 5.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import GoogleMaps
import Core

extension Main {
    
    public class TripToDestinationPointSheet : Sheet<TripToDestinationPointLayout> {
        
        private var dispatchedVehicle: Vehicle!
        
        private var vehicleMarker: CoreMapMarker!
        private var pickUpMarker: CoreMapMarker!
        private var destinationMarker: CoreMapMarker!
        
        private var deviceLocation: CoreCoordinate!
        private var path: GMSMutablePath!
        
        public override func onLayoutAppear(layout: Main.TripToDestinationPointLayout) {
            
            dispatchedVehicle = dataStorage.grabDispatchedVehicle()
            
            vehicleMarker = CoreMapMarker(image: self.imageProvider.getTaxiIcon(), on: dispatchedVehicle.coordinate, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: vehicleMarker)
            
            pickUpMarker = CoreMapMarker(image: imageProvider.getMarkerIcon(), on: exchangeFlow.grabPickUpPointCoordinate()!, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: pickUpMarker)
            
            destinationMarker = CoreMapMarker(image: imageProvider.getMarkerIcon(), on: exchangeFlow.grabDestinationCoordinate()!, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: destinationMarker)
            
            deviceLocation = locationManager.getLastLocation()
            
            layout.mv.drawRoute(apiManager: apiManager, from: exchangeFlow.grabPickUpPointCoordinate()!, to: exchangeFlow.grabDestinationCoordinate()!, color: colorProvider.getRouteBlue()) { response in
                
                self.path = GMSMutablePath(fromEncodedPath: response["routes"].arrayValue.first!["overview_polyline"].dictionaryValue["points"]!.stringValue)
                
            }
            
            eventManager.listen(key: "dispatchedVehicleUpdated") {
                
                self.dispatchedVehicle = self.dataStorage.grabDispatchedVehicle()
                
                self.vehicleMarker.dragTo(coordinate: self.dispatchedVehicle.coordinate)
                
                layout.mv.focus(coordinates: [self.dispatchedVehicle.coordinate, self.exchangeFlow.grabPickUpPointCoordinate()!, self.exchangeFlow.grabDestinationCoordinate()!, self.deviceLocation], paths: [self.path!])
                
            }
            
            eventManager.listen(key: "tripEnded") {
                
                self.stateMachine.shouldMainSheetBeReset(state: true)
                self.stateMachine.shouldMainSheetShowReview(state: true)
                
                self.demonstrator.goBackFromTripToDestinationPointSheetToMainSheet()
                
            }
            
            
            
        }
        
    }
    
}
