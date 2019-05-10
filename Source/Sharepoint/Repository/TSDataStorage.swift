//
//  TSDataStorage.swift
//  Blender
//
//  Created by Erhan Emre Eroğlu on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core
import SwiftyJSON
import Alamofire
import AlamofireImage

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
    
    private var currentUser: CustomerInfo?
    public func letCurrentUser(json: JSON, completion: ((UIImage) -> ())?){
        if json["customerInfo"].exists() {
            let customJson = json["customerInfo"]
            let user = CustomerInfo()
            user.age = customJson["age"].stringValue
            user.compAddrName = customJson["compAddrName"].stringValue
            user.companyLocation = CoreCoordinate(latitude: customJson["compLat"].doubleValue, longitude: customJson["compLon"].doubleValue)
            user.compName = customJson["compName"].stringValue
            user.email = customJson["email"].stringValue
            if customJson["gender"].intValue == 0 {
                user.gender = .female
            }
            else {
                user.gender = .male
            }
            user.guarderPhone = customJson["guarderPhone"].stringValue
            user.homeAddrName = customJson["homeAddrName"].stringValue
            user.homeLocation = CoreCoordinate(latitude: customJson["homeLat"].doubleValue, longitude: customJson["homeLon"].doubleValue)
            user.level = customJson["level"].uIntValue
            user.nickname = customJson["nickName"].stringValue
            user.occupation = customJson["occupation"].stringValue
            user.photo = customJson["photo"].stringValue
            user.trade = customJson["trade"].stringValue
            user.userId = customJson["userId"].uIntValue
            if user.photo != "" {
                Alamofire.request("https://portal.taksimizmir.com\(user.photo)").responseImage { (response) in
                    if let image = response.result.value {
                        user.profilePicture = image
                        completion?(image)
                    }
                }
            }
            self.currentUser = user
        }
    }
    public func letCurrentUser(customer: CustomerInfo) {
        self.currentUser = customer
    }
    public func grabCurrentUser() -> CustomerInfo? {
        return self.currentUser
    }
    public func resetCurrentUser(){
        self.currentUser = nil
    }
    
    private var dispatchedVehicle: Vehicle?
    public func storeDispathedVehicle(vehicle: Vehicle?) {
        self.dispatchedVehicle = vehicle
    }
    public func grabDispatchedVehicle() -> Vehicle? {
        return self.dispatchedVehicle
    }
    
    private var dispatchedDriver: Driver?
    public func storeDispatchedDriver(json: JSON, completion: (() -> ())?) {
        if json["driverInfo"].exists() {
            let customJSON = json["driverInfo"]
            dispatchedDriver = Driver()
            dispatchedDriver!.mdtMobile = customJSON["mdtMobile"].stringValue
            dispatchedDriver!.driverMobile = customJSON["driverMobile"].string
            dispatchedDriver!.compName = customJSON["compName"].stringValue
            dispatchedDriver!.mdtId = customJSON["mdtId"].stringValue
            dispatchedDriver!.payType = customJSON["payType"].stringValue
            dispatchedDriver!.driverName = customJSON["driverName"].string
            dispatchedDriver!.driverNo = customJSON["driverNo"].string
            dispatchedDriver!.personalId = customJSON["personalId"].stringValue
            dispatchedDriver!.photo = customJSON["photo"].stringValue
            dispatchedDriver!.driverLevel = customJSON["driverLevel"].uIntValue
            if dispatchedDriver!.photo != "" {
                Alamofire.request("https://portal.taksimizmir.com/\(dispatchedDriver!.photo)").responseImage { (response) in
                    if let image = response.result.value {
                        self.dispatchedDriver!.image = image
                        completion?()
                    }
                }
            }
            else {
                completion?()
            }
        }
    }
    
    public func grabDispatchedDriver() -> Driver? {
        return self.dispatchedDriver
    }
    
    public func resetDispatchedDriver() {
        self.dispatchedDriver = nil
    }
    
}
