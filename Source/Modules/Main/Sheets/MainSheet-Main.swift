//
//  mainMainSheet.swift
//  Taksim
//
//  Created by Can Özcan on 25.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//
import GooglePlaces
import GoogleMaps
import Core

extension Main {
    
    public class MainSheet: Sheet<MainLayout>, GMSAutocompleteViewControllerDelegate {
    
        private var vehicles: [Vehicle]!
        private var incomingVehicles: [Vehicle]!
        
        private var vehicleMarkers: [VehicleMapMarker]!
        
        private var pickUpMarker: CoreMapMarker!
        private var destinationMarker: CoreMapMarker!
        
        private var initialAddressFilled: Bool!
        
        public override func onInit() {
            
            vehicles = [Vehicle]()
            incomingVehicles = [Vehicle]()
            
            vehicleMarkers = [VehicleMapMarker]()
            
            initialAddressFilled = false
            
            locationManager.startTracking()
            
        }
        
        public override func onLayoutReappear(layout: Main.MainLayout) {
            
            if (stateMachine.mainSheetShouldBeReset()) {
                layout.mv.dragTo(coordinate: self.locationManager.getLastLocation(), zoom: 14)
                layout.o_quickorder.show()
                stateMachine.shouldMainSheetBeReset(state: false)
            }
            
            if (stateMachine.mainSheetShouldShowReview()) {
                layout.pu_review.show()
                stateMachine.shouldMainSheetShowReview(state: false)
            }
            
        }
        
        public override func onLayoutReady(layout: Main.MainLayout) {

            layout.mv.trackDeviceLocation()
            
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//                layout.mv.dragTo(coordinate: self.locationManager.getLastLocation())
//            }
      
            startTrackingVehicles(layout: layout)
            
            locationManager.onLocationUpdated = {
                
                if (!self.initialAddressFilled) {
                    
                    let coordinate = self.locationManager.getLastLocation()
                    self.exchangeFlow.letPickUpPointCoordinate(coordinate: coordinate)
                    
                    layout.mv.dragTo(coordinate: self.locationManager.getLastLocation(), zoom: 14)
                    
                    self.apiManager.getAddressFrom(coordinate: coordinate) { (address) in
                        
                        layout.o_quickorder.show()
                        layout.i_route.setPickUpAddress(address: address)
                        
                        self.exchangeFlow.letPickUpPointAddress(address: address)
                        
                        self.stateMachine.isPickUpPointSelected(state: true)
                        
                        self.initialAddressFilled = true
                        
                    }
                    
                }
                
            }
            
            eventManager.listen(key: "resetMainSheet") {
                
                self.vehicles = [Vehicle]()
                self.incomingVehicles = [Vehicle]()
                
                self.vehicleMarkers = [VehicleMapMarker]()
                
                self.stateMachine.isEditingPickUpPoint(state: false)
                self.stateMachine.isEditingDestinationPoint(state: false)
                
                self.stateMachine.isPickUpPointSelected(state: false)
                self.stateMachine.isDestinationPointSelected(state: false)
                
                self.exchangeFlow.letPickUpPointAddress(address: nil)
                self.exchangeFlow.letPickUpPointCoordinate(coordinate: nil)
                self.exchangeFlow.letDestinationAddress(address: nil)
                self.exchangeFlow.letDestinationCoordinate(coordinate: nil)
                
//                self.exchangeFlow.letSelectedVehicleNo(no: nil)
                self.exchangeFlow.letSelectedPlace(place: nil)
                
                layout.i_route.setPickUpAddress(address: "")
                layout.i_route.setDestinationAddress(address: "")
                
                layout.mv.clearRoute()
                layout.mv.clearMarkers()
                
                layout.o_quickorder.hide()
                layout.o_estimation.hide()
                
                let coordinate = self.locationManager.getLastLocation()
                self.exchangeFlow.letPickUpPointCoordinate(coordinate: coordinate)
                
                self.apiManager.getAddressFrom(coordinate: coordinate) { (address) in
                    
                    layout.o_quickorder.show()
                    layout.i_route.setPickUpAddress(address: address)
                    
                    self.exchangeFlow.letPickUpPointAddress(address: address)
                    
                    self.stateMachine.isPickUpPointSelected(state: true)
                    
                    self.startTrackingVehicles(layout: layout)
                    
                }
                
            }
            
            eventManager.listen(key: "updateRouteLocation") {
                
                layout.o_quickorder.hide()
                
                if (self.stateMachine.editingPickUpPoint()) {
                    layout.i_route.setPickUpAddress(address: self.exchangeFlow.grabPickUpPointAddress()!)
                }
                
                if (self.stateMachine.editingDestinationPoint()) {
                    layout.i_route.setDestinationAddress(address: self.exchangeFlow.grabDestinationAddress()!)
                }
                
                self.stateMachine.isEditingPickUpPoint(state: false)
                self.stateMachine.isEditingDestinationPoint(state: false)
                
                if (self.stateMachine.pickUpPointSelected() && self.stateMachine.destinationPointSelected()) {
                    
                    self.apiManager.stopTrackingVehicles()
                    
                    layout.mv.clearMarkers()
                    self.vehicleMarkers.removeAll()
                    
                    let pickUpPoint = self.exchangeFlow.grabPickUpPointCoordinate()!
                    let destinationPoint = self.exchangeFlow.grabDestinationCoordinate()!
                    
                    self.pickUpMarker = CoreMapMarker(image: self.imageProvider.getMarkerIcon(), on: pickUpPoint, size: layout.mv.lastScaledSize())
                    layout.mv.drawMarker(marker: self.pickUpMarker)
                    
                    self.destinationMarker = CoreMapMarker(image: self.imageProvider.getMarkerIcon(), on: destinationPoint, size: layout.mv.lastScaledSize())
                    layout.mv.drawMarker(marker: self.destinationMarker)
                    
                    layout.mv.drawRoute(apiManager: self.apiManager, from: pickUpPoint, to: destinationPoint, color: self.colorProvider.getRouteBlue()) { (response) in
                        
                        let route = response["routes"].arrayValue.first!["legs"].arrayValue.first!
                        layout.o_estimation.fillAttributes(distance: route["distance"].dictionaryValue["value"]!.intValue, duration: route["duration"].dictionaryValue["value"]!.intValue)
                        
                        let routeString = response["routes"].array!.first!.dictionary!["overview_polyline"]!.dictionary!["points"]!.stringValue
                        let path = GMSMutablePath(fromEncodedPath: routeString)!
                        
                        layout.mv.focus(on: [path])
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            layout.o_estimation.show()
                        })
                        
                    }
                }
            }
            
            layout.o_menu.onProfileClick = {
                self.demonstrator.toProfile()
            }
            
            layout.o_menu.onNotificationsClick = {
                self.demonstrator.toNotifications()
            }
            
            layout.o_menu.onPromotionClick = {
                self.demonstrator.toPromotion()
            }
            
            layout.o_menu.onHelpClick = {
                self.demonstrator.toHelp()
            }
            
            layout.o_menu.onFaqClick = {
                self.demonstrator.toFaq()
            }
            
            layout.o_menu.onTripsClick = {
                self.demonstrator.toOrderHistory()
            }
            
            layout.i_route.onPickUpPointEditing = {
                
                self.stateMachine.isEditingPickUpPoint(state: true)
                self.stateMachine.isEditingDestinationPoint(state: false)
                
                layout.o_estimation.hide()
                
                self.demonstrator.toAutoComplete(delegate: self)
                
            }
            
            layout.i_route.onDestinationPointEditing = {
                
                self.stateMachine.isEditingPickUpPoint(state: false)
                self.stateMachine.isEditingDestinationPoint(state: true)
            
                layout.o_estimation.hide()
                
                self.demonstrator.toAutoComplete(delegate: self)
                
            }
            
            layout.o_quickorder.onOrder = {
                
                let order = Order()
                order.orderTime = Date()
                order.orderCoordinate = self.exchangeFlow.grabPickUpPointCoordinate()!
                order.orderAddrName = self.exchangeFlow.grabPickUpPointAddress()!
                order.orderType = 0
                order.destinationCoordinate = CoreCoordinate(latitude: 0, longitude: 0)
                order.destAddrName = ""
                order.carType = 1
                order.isShared = 0
                order.remarks = ""
                
                layout.o_loading.show()
                
                self.apiManager.createOrder(mobilePhone: self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) as! String,
                                            token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String,
                                            order: order)
                { res in
                    
                    if res["orderId"].exists() {
                        self.dataStorage.storeOrderId(id: res["orderId"].uIntValue)
                    }
                                                
                    self.apiManager.startTrackingOrder(onSuccess: {
                        
                        
                        
                        print("App: Order matched with a Taxi")
                        
                        layout.o_loading.hide()
                        
                        self.demonstrator.toTripToPickUpPoint()
                        
                    }, onCancel: {
                        
                        print("App: I canceled the trip")
                        
                        layout.o_loading.hide()
                        
                    }, onFail: {
                        
                        print("App: Order did not match with any Taxi")
                        
                    }, onTripStarted: {
                        
                        print("App: Trip started")
                        
                    }, onPayment: {
                        
                        print("App: Trip ended and paid")
                        
                    })
                    
                }
                
            }
            
            layout.o_estimation.onOrder = {
                
                let order = Order()
                order.orderTime = Date()
                order.orderCoordinate = self.exchangeFlow.grabPickUpPointCoordinate()!
                order.orderAddrName = self.exchangeFlow.grabPickUpPointAddress()!
                order.orderType = 0
                order.destinationCoordinate = self.exchangeFlow.grabDestinationCoordinate()!
                order.destAddrName = self.exchangeFlow.grabDestinationAddress()!
                order.carType = 1
                order.isShared = 0
                order.remarks = ""
                
                layout.o_loading.show()
                
                self.apiManager.createOrder(mobilePhone: self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) as! String,
                                            token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String,
                                            order: order)
                { res in
                                                
                    if res["orderId"].exists() {
                        self.dataStorage.storeOrderId(id: res["orderId"].uIntValue)
                    }
                    
                                                
                    self.apiManager.startTrackingOrder(onSuccess: {
                        
                        print("Order matched with a Taxi")
                        
                        layout.o_loading.hide()
                        
                        self.demonstrator.toTripToPickUpPoint()
                        
                    }, onCancel: {
                        
                        print("I canceled the trip")
                        
                        layout.o_loading.hide()
                        
                    }, onFail: {
                        
                        print("Order did not match with any Taxi")
                        
                    }, onTripStarted: {
                        
                        print("Trip started")
                        
                        self.eventManager.shout(key: "tripStarted")
                        
                    }, onPayment: {
                        
                        print("Trip ended and paid")
                        
                        self.eventManager.shout(key: "tripEnded")
                        
                    })
                    
                }
                
            }
        }
    
//        public override func onDismiss() {
//            eventManager.forget(key: "updateRouteLocation")
//        }
//        
//        private func startTrackingVehicles(layout: Main.MainLayout) {
//            
//            apiManager.startTrackingVehicles(coordinate: layout.mv.pickCenter, radius: 10000) {
//                
//                self.incomingVehicles = self.dataStorage.grabAvailableVehicles()
//                
//                for vehicle in self.incomingVehicles {
//                    
//                    if let existingVehicle = self.vehicles.filter({ (v) -> Bool in v == vehicle }).first {
//                        
//                        existingVehicle.coordinate = vehicle.coordinate
//                        existingVehicle.direction = vehicle.direction
//                        
//                        let marker = self.vehicleMarkers.filter({ (m) -> Bool in m.vehicle == existingVehicle }).first
//                        marker?.dragTo(coordinate: existingVehicle.coordinate)
//                        
//                    } else {
//                        
//                        let marker = VehicleMapMarker(image: self.imageProvider.getTaxiIcon(), on: vehicle.coordinate, size: layout.mv.lastScaledSize())
//                        marker.vehicle = vehicle
//                        self.vehicleMarkers.append(marker)
//                        
//                        layout.mv.drawMarker(marker: marker)
//                        
//                        self.vehicles.append(vehicle)
//                        
//                    }
//                    
//                }
//                
//                for vehicle in self.vehicles {
//                    
//                    if self.incomingVehicles.filter({ (v) -> Bool in v == vehicle }).count == 0 {
//                        
//                        let marker = self.vehicleMarkers.filter({ (m) -> Bool in m.vehicle == vehicle }).first!
//                        layout.mv.removeMarker(marker: marker)
//                        
//                        self.vehicles.removeAll { (v) -> Bool in v == vehicle }
//                        
//                    }
//                    
//                }
//                
//            }
//            
//        }
        
        public override func onDismiss() {
            eventManager.forget(key: "updateRouteLocation")
        }
        
        private func startTrackingVehicles(layout: Main.MainLayout) {
            
            apiManager.startTrackingVehicles(coordinate: layout.mv.pickCenter, radius: 10000, token: persistentStorage.recall(key: persistentStorage.tokenKey) as! String) {
                
                self.incomingVehicles = self.dataStorage.grabAvailableVehicles()
                
                for vehicle in self.incomingVehicles {
                    
                    if let existingVehicle = self.vehicles.filter({ (v) -> Bool in v == vehicle }).first {
                        
                        existingVehicle.coordinate = vehicle.coordinate
                        existingVehicle.direction = vehicle.direction
                        
                        let marker = self.vehicleMarkers.filter({ (m) -> Bool in m.vehicle == existingVehicle }).first
                        marker?.dragTo(coordinate: existingVehicle.coordinate)
                        
                    } else {
                        
                        let marker = VehicleMapMarker(image: self.imageProvider.getTaxiIcon(), on: vehicle.coordinate, size: layout.mv.lastScaledSize())
                        marker.vehicle = vehicle
                        self.vehicleMarkers.append(marker)
                        
                        layout.mv.drawMarker(marker: marker)
                        
                        self.vehicles.append(vehicle)
                        
                    }
                    
                }
                
                for vehicle in self.vehicles {
                    
                    if self.incomingVehicles.filter({ (v) -> Bool in v == vehicle }).count == 0 {
                        
                        let markers = self.vehicleMarkers.filter({ (m) -> Bool in m.vehicle == vehicle })
                        for marker in markers {
                            layout.mv.removeMarker(marker: marker)
                        }
                        self.vehicles.removeAll { (v) -> Bool in v == vehicle }
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
        public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            
            self.exchangeFlow.letSelectedPlace(place: place)
            
            self.demonstrator.toCoordinateSelection()
            
        }
        
        public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }
        
        public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            self.demonstrator.goBack()
        }
        
        public func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        public func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
    
    
}
