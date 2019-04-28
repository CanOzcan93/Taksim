//
//  TSExchangeFlow.swift
//  Blender
//
//  Created by Erhan Emre Eroğlu on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core
import GooglePlaces
import SwiftyJSON

public class TSExchangeFlow: CoreExchangeFlow {
    
    private var lastSelectedPlace: GMSPlace?
    public func letSelectedPlace(place: GMSPlace?) {
        self.lastSelectedPlace = place
    }
    public func grabLastSelectedPlace() -> GMSPlace? {
        return self.lastSelectedPlace
    }
    
    private var pickUpPointCoordinate: CoreCoordinate?
    public func letPickUpPointCoordinate(coordinate: CoreCoordinate?) {
        self.pickUpPointCoordinate = coordinate
    }
    public func grabPickUpPointCoordinate() -> CoreCoordinate? {
        return self.pickUpPointCoordinate
    }
    
    private var pickUpPointAddress: String?
    public func letPickUpPointAddress(address: String?) {
        self.pickUpPointAddress = address
    }
    public func grabPickUpPointAddress() -> String? {
        return self.pickUpPointAddress
    }
    
    private var destinationPointCoordinate: CoreCoordinate?
    public func letDestinationCoordinate(coordinate: CoreCoordinate?) {
        self.destinationPointCoordinate = coordinate
    }
    public func grabDestinationCoordinate() -> CoreCoordinate? {
        return self.destinationPointCoordinate
    }
    
    private var destinationPointAddress: String?
    public func letDestinationAddress(address: String?) {
        self.destinationPointAddress = address
    }
    public func grabDestinationAddress() -> String? {
        return self.destinationPointAddress
    }
    
    private var currentUser: CustomerInfo?
    public func letCurrentUser(json: JSON){
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
            self.currentUser = user
        }
    }
    public func letCurrentUser(customer: CustomerInfo) {
        self.currentUser = customer
    }
    public func grabCurrentUser() -> CustomerInfo? {
        return self.currentUser
    }
    
    private var phoneNumberForSignUpOrLogin: String?
    public func letPhoneNumberForSignUpOrLogin(phoneNumber: String) {
        self.phoneNumberForSignUpOrLogin = phoneNumber
    }
    public func grabPhoneNumberForSignUpOrLogin() -> String? {
        return self.phoneNumberForSignUpOrLogin
    }
    

//    private var selectedVehicleNo: String?
//    public func letSelectedVehicleNo(no: String?) {
//        self.selectedVehicleNo = no
//    }
//    public func grabSelectedVehicleNo() -> String? {
//        return self.selectedVehicleNo
//    }
//
    
}
