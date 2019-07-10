//
//  TripToDestinationPointSheet.swift
//  Taksim
//
//  Created by Can Özcan on 5.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import GoogleMaps
import Core
import ReactiveObjC

extension Main {
    
    public class TripToDestinationPointSheet : Sheet<TripToDestinationPointLayout> {
        
        private var dispatchedVehicle: Vehicle!
        
        private var vehicleMarker: CoreMapMarker!
        private var pickUpMarker: CoreMapMarker!
        private var destinationMarker: CoreMapMarker!
        
        private var deviceLocation: CoreCoordinate!
        private var path: GMSMutablePath!
        
        private var disposable: RACDisposable!
        
        public override func onLayoutReady(layout: Main.TripToDestinationPointLayout) {
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.dispatchedVehicle = self.dataStorage.grabDispatchedVehicle()
                layout.mv.dragTo(coordinate: self.dispatchedVehicle.coordinate, angle: Double(self.dispatchedVehicle.direction), zoom: 16)
                
            }
            
            layout.btn_curLoc.onClick {
                self.dispatchedVehicle = self.dataStorage.grabDispatchedVehicle()
                layout.mv.dragTo(coordinate: self.dispatchedVehicle.coordinate, angle: Double(self.dispatchedVehicle.direction), zoom: 16)
            }
            
            self.eventManager.forget(key: "dispatchedVehicleUpdated")
         
            eventManager.listen(key: "tripEnded") {
                
                self.disposable = RACSignal<AnyObject>.interval(30, on: RACScheduler(priority: RACSchedulerPriorityBackground)).subscribeNext { (date) in
                    if self.stateMachine.pickUpSheetAppeared() {
                        self.stateMachine.shouldMainSheetBeReset(state: true)
                    }
                    self.stateMachine.shouldMainSheetShowReview(state: true)
                    
                    self.demonstrator.goBackFromTripToDestinationPointSheetToMainSheet()
                    self.exchangeFlow.resetAmountOfOrder()
                    self.disposable.dispose()
                }
                
                layout.st_overlay.changeStatus(text: "Yolculuğunuz Tamamlandı")
                layout.pay_overlay.changeAmount(payment: self.exchangeFlow.grabAmountOfOrder())
                layout.pay_overlay.show()
                layout.pay_overlay.onApprove = {
                    if self.stateMachine.pickUpSheetAppeared() {
                        self.stateMachine.shouldMainSheetBeReset(state: true)
                    }
                    self.stateMachine.shouldMainSheetShowReview(state: true)
                    
                    self.demonstrator.goBackFromTripToDestinationPointSheetToMainSheet()
                    self.exchangeFlow.resetAmountOfOrder()
                    self.disposable.dispose()
                    self.eventManager.forget(key: "tripEnded")
                }
            }
 
        }
        
        public override func onLayoutAppear(layout: Main.TripToDestinationPointLayout) {
            
            dispatchedVehicle = dataStorage.grabDispatchedVehicle()
//            locationManager.changeMapCurrentMarker(map: layout.mv)
            
            if self.stateMachine.notQuickOrderStarted() {
                
                vehicleMarker = CoreMapMarker(image: self.imageProvider.getTaxiIcon(), on: dispatchedVehicle.coordinate, size: layout.mv.lastScaledSize(), centered: false)
                layout.mv.drawMarker(marker: vehicleMarker)
                
//                pickUpMarker = CoreMapMarker(image: imageProvider.getMarkerIcon(), on: exchangeFlow.grabPickUpPointCoordinate()!, size: layout.mv.lastScaledSize(), centered: false)
//                layout.mv.drawMarker(marker: pickUpMarker)
                
                destinationMarker = CoreMapMarker(image: imageProvider.getMarkerIcon(), on: exchangeFlow.grabDestinationCoordinate()!, size: layout.mv.lastScaledSize(), centered: false)
                layout.mv.drawMarker(marker: destinationMarker)
                
                deviceLocation = locationManager.getLastLocation()
                
                layout.mv.drawRoute(apiManager: apiManager, from: exchangeFlow.grabPickUpPointCoordinate()!, to: exchangeFlow.grabDestinationCoordinate()!, color: colorProvider.getRouteBlue()) { response in
                    
                    self.path = GMSMutablePath(fromEncodedPath: response["routes"].arrayValue.first!["overview_polyline"].dictionaryValue["points"]!.stringValue)
                    
                }
                
            }
            
            else {
                
                vehicleMarker = CoreMapMarker(image: self.imageProvider.getTaxiIcon(), on: dispatchedVehicle.coordinate, size: layout.mv.lastScaledSize(), centered: false)
                layout.mv.drawMarker(marker: vehicleMarker)
                
            }
            
            eventManager.listen(key: "dispatchedVehicleUpdated") {
                
                self.dispatchedVehicle = self.dataStorage.grabDispatchedVehicle()
                
                self.vehicleMarker.dragTo(coordinate: self.dispatchedVehicle.coordinate)
                
                //                    layout.mv.focus(coordinates: [self.dispatchedVehicle.coordinate, self.exchangeFlow.grabPickUpPointCoordinate()!, self.exchangeFlow.grabDestinationCoordinate()!, self.deviceLocation], paths: [self.path!])
                
            }

            
            
            
            
            
            
        }
        
    }
    
}
