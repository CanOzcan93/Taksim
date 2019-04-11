//
//  TripToPickUpPointSheet-Main.swift
//  Taksim
//
//  Created by Can Özcan on 30.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import GoogleMaps
import Core

extension Main {
    
    public class TripToPickUpPointSheet : Sheet<TripToPickUpPointLayout> {
        
        private var dispatchedVehicle: Vehicle!
        
        private var vehicleMarker: CoreMapMarker!
        private var pickUpMarker: CoreMapMarker!
        
        private var deviceLocation: CoreCoordinate!
        private var path: GMSMutablePath!
        
        public override func onLayoutAppear(layout: Main.TripToPickUpPointLayout) {
            
            dispatchedVehicle = dataStorage.grabDispatchedVehicle()
            
            vehicleMarker = CoreMapMarker(image: self.imageProvider.getTaxiIcon(), on: dispatchedVehicle.coordinate, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: vehicleMarker)
            
            pickUpMarker = CoreMapMarker(image: imageProvider.getMarkerIcon(), on: exchangeFlow.grabPickUpPointCoordinate()!, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: pickUpMarker)
            
            deviceLocation = locationManager.getLastLocation()
            
            layout.mv.drawRoute(apiManager: apiManager, from: dispatchedVehicle.coordinate, to: exchangeFlow.grabPickUpPointCoordinate()!, color: colorProvider.getRouteBlue()) { response in
                
                let route = response["routes"].arrayValue.first!["legs"].arrayValue.first!
                layout.o_driver.setDuration(duration: route["duration"].dictionaryValue["value"]!.intValue)
                
                self.path = GMSMutablePath(fromEncodedPath: response["routes"].arrayValue.first!["overview_polyline"].dictionaryValue["points"]!.stringValue)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { layout.o_driver.show() }
                
            }
            
            eventManager.listen(key: "dispatchedVehicleUpdated") {
                
                self.dispatchedVehicle = self.dataStorage.grabDispatchedVehicle()
                
                self.vehicleMarker.dragTo(coordinate: self.dispatchedVehicle.coordinate)
                
                layout.mv.focus(coordinates: [self.dispatchedVehicle.coordinate, self.exchangeFlow.grabPickUpPointCoordinate()!, self.deviceLocation], paths: [self.path!])
                
            }
            
            eventManager.listen(key: "tripStarted") {
                
                self.demonstrator.toTripToDestinationPoint()
                
            }
            
//            layout.mv.focus(on: [selectedVehicle.coordinate, exchangeFlow.grabPickUpPointCoordinate()!, deviceLocation])
            
//            var trackingEnabled = true
//            layout.mv.drawRoute(apiManager: apiManager, from: selectedVehicle.coordinate, to: exchangeFlow.grabPickUpPointCoordinate()!, color: colorProvider.getRouteBlue()) { response in
//
//                let route = response["routes"].arrayValue.first!["legs"].arrayValue.first!
//                layout.o_driver.setDuration(duration: route["duration"].dictionaryValue["value"]!.intValue)
//
//                self.apiManager.startTrackingVehicles(coordinate: { return self.selectedVehicle.coordinate }, radius: 1000) {
//
//                    if (trackingEnabled) {
//
//                        let vehicles = self.dataStorage.grabAvailableVehicles()
//
//                        self.selectedVehicle = vehicles.filter({ (v) -> Bool in v.no == self.selectedVehicleNo }).first
//
//                        self.vehicleMarker.dragTo(coordinate: self.selectedVehicle.coordinate)
//
//                        if let ppc = self.exchangeFlow.grabPickUpPointCoordinate() {
//
//                            layout.mv.focus(on: [self.selectedVehicle.coordinate, ppc, self.deviceLocation])
//
//                        }
//
//                    }
//
//                }
//
//            }
            
            layout.o_driver.onCall = {
                self.demonstrator.toCallSheet()
            }
            
            layout.o_driver.onCancel = {
                
                let popup = CancellationPopup(layout: layout)
                
                popup.onYes = {
                    
                    self.apiManager.cancelOrder(orderID: self.dataStorage.grabOrderId()!, reason: 0) { res in
                        
                        self.stateMachine.shouldMainSheetBeReset(state: true)
                        self.eventManager.shout(key: "resetMainSheet")
                        
                        self.demonstrator.goBackToMainSheet()
                        
                        layout.mv.clearRoute()
                        layout.mv.clearMarkers()
                        
                        layout.o_driver.hide()
                        popup.hide()
                        
                    }
                    
//                    self.apiManager.stopTrackingVehicles()
//                    trackingEnabled = false
//
//                    self.stateMachine.shouldMainSheetBeReset(state: true)
//                    self.eventManager.shout(key: "resetMainSheet")
//
//                    self.demonstrator.goBackToMainSheet()
//
//                    layout.mv.clearRoute()
//                    layout.mv.clearMarkers()
//
//                    layout.o_driver.hide()
//                    popup.hide()
                    
                }
                
                popup.show()
                
            }
            
        }
        
    }
    
}
