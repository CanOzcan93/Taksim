//
//  TSDataStorage.swift
//  Blender
//
//  Created by Erhan Emre Eroğlu on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

public class TSDataStorage: CoreDataStorage {
    
    private var availableVehicles = [Vehicle]()
    public func storeAvailableVehicles(vehicles: [Vehicle]) {
        self.availableVehicles = vehicles
    }
    public func storeAvailableVehicle(vehicle: Vehicle) {
        self.availableVehicles.append(vehicle)
    }
    public func removeAvailableVehicle(vehicle: Vehicle) {
        self.availableVehicles.removeAll { (v) -> Bool in v == vehicle }
    }
    public func grabAvailableVehicles() -> [Vehicle] {
        return self.availableVehicles
    }
    public func clearAvailableVehicles() {
        self.availableVehicles.removeAll()
    }
    
    private var orderId: UInt?
    public func storeOrderId(id: UInt?) {
        self.orderId = id
    }
    public func grabOrderId() -> UInt? {
        return self.orderId
    }
    
    private var dispatchedVehicle: Vehicle?
    public func storeDispathedVehicle(vehicle: Vehicle?) {
        self.dispatchedVehicle = vehicle
    }
    public func grabDispatchedVehicle() -> Vehicle? {
        return self.dispatchedVehicle
    }
    
}
