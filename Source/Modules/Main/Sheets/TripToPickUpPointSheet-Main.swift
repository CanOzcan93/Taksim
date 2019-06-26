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
        private var dispatchedDriver: Driver!
        
        private var vehicleMarker: CoreMapMarker!
        private var pickUpMarker: CoreMapMarker!
        
        private var deviceLocation: CoreCoordinate!
        private var path: GMSMutablePath!
        
        private var drawn = false
        
        public override func onLayoutReady(layout: Main.TripToPickUpPointLayout) {
            
            let orderId = self.dataStorage.grabOrderId()!
            dispatchedVehicle = dataStorage.grabDispatchedVehicle()
            dispatchedDriver = dataStorage.grabDispatchedDriver()
            
            layout.o_driver.setDriverInfo(driver: dispatchedDriver, vehicle: dispatchedVehicle)
            
            vehicleMarker = CoreMapMarker(image: self.imageProvider.getTaxiIcon(), on: dispatchedVehicle.coordinate, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: vehicleMarker)
            
            pickUpMarker = CoreMapMarker(image: imageProvider.getMarkerIcon(), on: exchangeFlow.grabPickUpPointCoordinate()!, size: layout.mv.lastScaledSize())
            layout.mv.drawMarker(marker: pickUpMarker)
            
            deviceLocation = locationManager.getLastLocation()
            
            
            eventManager.listen(key: "dispatchedVehicleUpdated") {
                
                self.dispatchedVehicle = self.dataStorage.grabDispatchedVehicle()
                
                self.vehicleMarker.dragTo(coordinate: self.dispatchedVehicle.coordinate)
                
                if !self.drawn {
                    layout.mv.drawRoute(apiManager: self.apiManager, from: self.dispatchedVehicle.coordinate, to: self.exchangeFlow.grabPickUpPointCoordinate()!, color: self.colorProvider.getRouteBlue()) { response in
                        
                        let route = response["routes"].arrayValue.first!["legs"].arrayValue.first!
                        layout.o_driver.setDuration(duration: route["duration"].dictionaryValue["value"]!.intValue)
                        
                        self.path = GMSMutablePath(fromEncodedPath: response["routes"].arrayValue.first!["overview_polyline"].dictionaryValue["points"]!.stringValue)
                        
                        layout.mv.focus(coordinates: [self.dispatchedVehicle.coordinate, self.exchangeFlow.grabPickUpPointCoordinate()!, self.deviceLocation], paths: [self.path!])
                        
                        self.drawn = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { layout.o_driver.show() }
                        
                    }
                }
                
                
                
                
            }
            
            eventManager.listen(key: "tripStarted") {
                
                self.demonstrator.toTripToDestinationPoint()
                
            }
            
            layout.o_driver.onCall = {
                self.networkManager.callOut()
                self.stateMachine.isCallConnected(state: false)
                self.demonstrator.toCallSheet()
            }
            
            layout.o_driver.onCancel = {
                
                let popup = CancellationPopup(layout: layout)
                
                popup.onYes = {
                    
                    self.apiManager.cancelOrder(orderID: self.dataStorage.grabOrderId()!, reason: 0, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) {
                        res in
                        
                        self.networkManager.disposable.dispose()
                        
                        self.stateMachine.shouldMainSheetBeReset(state: true)
                        self.eventManager.shout(key: "resetMainSheet")
                        
                        self.demonstrator.goBackToMainSheet()
                        
                        layout.mv.clearRoute()
                        layout.mv.clearMarkers()
                        
                        layout.o_driver.hide()
                        popup.hide()
                        
                    }
                    
                }
                
                popup.show()
                
            }
            
            self.networkManager.receiveMessageString = { message in
                print("Right now you receive this message from websocket:\n \(message)")
            }
            
            self.networkManager.open()
            
            self.networkManager.pongResult = {
                print("Pong ettim sana\n")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.networkManager.registerWithOrderId(orderId: "\(orderId)", carNo: self.dispatchedVehicle.no, mdtId: self.dispatchedDriver.mdtId)
            }
            
            
            
            self.networkManager.registerResult = { state in
                print("Register is \(state)")
            }
            
            self.networkManager.receiveCallOutResult = {
                
                let callPopup = CallPopup(layout: layout)
                callPopup.onYes = {
                    self.networkManager.receiveCallOut(accept: true)
                    self.stateMachine.isCallConnected(state: true)
                    self.demonstrator.toCallSheet()
                }
                callPopup.onNo = {
                    self.networkManager.hangUp()
                }
                callPopup.show()
                
            }
        }
        
    }
}
