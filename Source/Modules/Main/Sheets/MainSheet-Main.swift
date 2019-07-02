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
        
        public override func onLayoutFirstAppear(layout: Main.MainLayout) {
            if dataStorage.grabOrderId() != nil {
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
                    self.apiManager.startTrackingOrder(onSuccess: {
                        
                        print("App: Order matched with a Taxi")
                        
                        layout.o_loading.hide()
                        
                        self.demonstrator.toTripToPickUpPoint {
                            self.stateMachine.isPickUpSheetAppear(state: true)
                        }
                        
                    }, onCancel: {
                        
                        print("App: I canceled the trip")
                        
                        layout.o_loading.hide()
                        
                    }, onFail: {
                        
                        print("App: Order did not match with any Taxi")
                        
                    }, onTripStarted: {
                        print("App: Trip started")
                        self.demonstrator.toTripToDestinationPoint()
                        
                    }, onPayment: {
                        
                        print("App: Trip ended and paid")
                        
                        self.eventManager.shout(key: "tripEnded")
                        
                    })
                }
                
            }
        }
        
        public override func onLayoutReappear(layout: Main.MainLayout) {
            
            locationManager.changeMapCurrentMarker(map: layout.mv)
            
            if (stateMachine.mainSheetShouldBeReset()) {
                layout.mv.dragTo(coordinate: self.locationManager.getLastLocation(), zoom: 14)
                layout.o_quickorder.show()
                stateMachine.shouldMainSheetBeReset(state: false)
                self.eventManager.shout(key: "resetMainSheet")
            }
            
            if (stateMachine.mainSheetShouldShowReview()) {
                layout.pu_review.show()
                stateMachine.shouldMainSheetShowReview(state: false)
            }
            
            if let profilePicture = self.dataStorage.grabCurrentUser()!.profilePicture {
                let scaledImage = profilePicture.scaleImageToFitSize(size: CGSize(width: 60, height: 60))
                layout.o_menu.iv_avatar.image = scaledImage.roundedImage
            }
            
        }
        
        public override func onLayoutReady(layout: Main.MainLayout) {

            self.locationManager.activateCurrentLocationMarker(image: imageProvider.getLocationMarkerIcon(), map: layout.mv)
            
            layout.o_loading.iv_cancel.onTap {
                
                let popup = CancellationPopup(layout: layout)
                
                popup.onYes = {
                    
                    self.apiManager.cancelOrder(orderID: self.dataStorage.grabOrderId()!, reason: 0, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) {
                        (json) in
                        print(json)
                        
                        popup.hide()
                    }
                    
                }
                
                
                popup.show()
                
            }
            
            layout.btn_curLoc.onClick {
                layout.mv.dragTo(coordinate: self.locationManager.getLastLocation(), zoom: 16)
            }
      
            startTrackingVehicles(layout: layout)
            
            layout.pu_review.btn_send.onClick({
                
                self.apiManager.evaluateOrder(
                    orderID: self.dataStorage.grabOrderId()!,
                    carNo: self.dataStorage.grabDispatchedVehicle()!.no,
                    driverNo: self.dataStorage.grabDispatchedDriver()!.driverNo!,
                    evaluation: layout.pu_review!.rating!,
                    token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) { json in
                        if json["errCode"].uIntValue != 0 {
                        }
                        layout.pu_review.reviewReceived()
                        layout.endEditing(true)
                    }
            })
            layout.iv_menu.onTap {
                layout.o_menu.show()
                if let profilePicture = self.dataStorage.grabCurrentUser()!.profilePicture {
                    let scaledImage = profilePicture.scaleImageToFitSize(size: CGSize(width: 60, height: 60))
                    layout.o_menu.iv_avatar.image = scaledImage.roundedImage
                }
            }
            
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
                
                self.eventManager.forget(key: "tripStarted")
                self.eventManager.forget(key: "tripEnded")
                
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
                
                self.exchangeFlow.letSelectedPlace(place: nil)
                
                layout.i_route.setPickUpAddress(address: "")
                layout.i_route.setDestinationAddress(address: "")
                
                layout.mv.clearRoute()
                layout.mv.clearMarkers()
                
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
                    
                    self.pickUpMarker = CoreMapMarker(image: self.imageProvider.getMarkerIcon(), on: pickUpPoint, size: layout.mv.lastScaledSize(), centered: false)
                    layout.mv.drawMarker(marker: self.pickUpMarker)
                    
                    self.destinationMarker = CoreMapMarker(image: self.imageProvider.getMarkerIcon(), on: destinationPoint, size: layout.mv.lastScaledSize(), centered: false)
                    layout.mv.drawMarker(marker: self.destinationMarker)
                    
                    layout.mv.drawRoute(apiManager: self.apiManager, from: pickUpPoint, to: destinationPoint, color: self.colorProvider.getRouteBlue()) { (response) in
                        
                        let route = response["routes"].arrayValue.first!["legs"].arrayValue.first!
                        layout.o_estimation.fillAttributes(distance: route["distance"].dictionaryValue["value"]!.intValue, duration: route["duration"].dictionaryValue["value"]!.intValue)
                        
                        let routeString = response["routes"].array!.first!.dictionary!["overview_polyline"]!.dictionary!["points"]!.stringValue
                        let path = GMSMutablePath(fromEncodedPath: routeString)!
                        
                        layout.mv.focus(on: [path])
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            layout.o_quickorder.hide()
                            layout.o_estimation.show()
                        })
                        
                    }
                }
            }
            
            layout.o_menu.onProfileClick = {
                self.demonstrator.toProfile()
            }
            
            layout.o_menu.onAddressesClick = {
                self.demonstrator.toAddressSheet()
            }
            
            layout.o_menu.onCardsClick = {
                self.demonstrator.toCreditCardsSheet()
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
            
            layout.o_menu.onExitClick = {
                self.vehicles = []
                self.incomingVehicles = []
                self.stateMachine.isEditingPickUpPoint(state: false)
                self.stateMachine.isEditingDestinationPoint(state: false)
                
                self.stateMachine.isPickUpPointSelected(state: false)
                self.stateMachine.isDestinationPointSelected(state: false)
                
                self.exchangeFlow.letPickUpPointAddress(address: nil)
                self.exchangeFlow.letPickUpPointCoordinate(coordinate: nil)
                self.exchangeFlow.letDestinationAddress(address: nil)
                self.exchangeFlow.letDestinationCoordinate(coordinate: nil)
                
                self.exchangeFlow.letSelectedPlace(place: nil)
                self.dataStorage.resetCurrentUser()
                
                layout.i_route.setPickUpAddress(address: "")
                layout.i_route.setDestinationAddress(address: "")
                
                layout.mv.clearRoute()
                layout.mv.clearMarkers()
                
                self.persistentStorage.remove(key: self.persistentStorage.tokenKey)
                
                self.demonstrator.dismissViewControllers {
                    
                    Main.Module.resetInstance()
                    Profile.Module.resetInstance()
                    About.Module.resetInstance()
                    PostLogin.Module.resetInstance()
                    TSSharepoint.resetSharepoint()
                }
            }
            
            layout.i_route.onPickUpPointEditing = {
                
                self.stateMachine.isEditingPickUpPoint(state: true)
                self.stateMachine.isEditingDestinationPoint(state: false)
                
                //                layout.o_estimation.hide()
                
                self.demonstrator.toAutoComplete(delegate: self)
                
            }
            
            layout.i_route.onDestinationPointEditing = {
                
                self.stateMachine.isEditingPickUpPoint(state: false)
                self.stateMachine.isEditingDestinationPoint(state: true)
            
                //                layout.o_estimation.hide()
                
                self.demonstrator.toAutoComplete(delegate: self)
                
            }
            
            layout.o_quickorder.onOrder = {
                
                self.stateMachine.isQuickOrder(state: true)
                
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
                        
                        self.demonstrator.toTripToPickUpPoint {
                            self.stateMachine.isPickUpSheetAppear(state: true)
                        }
                        
                    }, onCancel: {
                        
                        print("App: I canceled the trip")
                        
                        layout.o_loading.hide()
                        
                    }, onFail: {
                        
                        print("App: Order did not match with any Taxi")
                        
                    }, onTripStarted: {
                        
                        self.eventManager.shout(key: "tripStarted")
                        
                        print("App: Trip started")
                        
                    }, onPayment: {
                        
                        print("App: Trip ended and paid")
                        
                        self.eventManager.shout(key: "tripEnded")
                        
                    })
                    
                }
                
            }
            
            layout.o_estimation.onOrder = {
                
                self.stateMachine.isQuickOrder(state: false)
                
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
                        
                        self.demonstrator.toTripToPickUpPoint {
                            self.stateMachine.isPickUpSheetAppear(state: true)
                        }
                        
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
                        
                        let marker = VehicleMapMarker(image: self.imageProvider.getTaxiIcon(), on: vehicle.coordinate, size: layout.mv.lastScaledSize(), centered: false)
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
