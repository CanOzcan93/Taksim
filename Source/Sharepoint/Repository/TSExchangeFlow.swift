//
//  TSExchangeFlow.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core
import GooglePlaces

public class TSExchangeFlow: CoreExchangeFlow {
    
    private var lastSelectedPlace: CLLocationCoordinate2D?
    public func letSelectedPlace(place: CLLocationCoordinate2D?) {
        self.lastSelectedPlace = place
    }
    public func letSelectedPlace(place: GMSPlace) {
        self.lastSelectedPlace = place.coordinate
    }
    public func grabLastSelectedPlace() -> CLLocationCoordinate2D? {
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
    
    private var phoneNumberForSignUpOrLogin: String?
    public func letPhoneNumberForSignUpOrLogin(phoneNumber: String) {
        self.phoneNumberForSignUpOrLogin = phoneNumber
    }
    public func grabPhoneNumberForSignUpOrLogin() -> String? {
        return self.phoneNumberForSignUpOrLogin
    }
    
    private var smsCodeForSignUpOrLogin: String?
    public func letSmsCodeForSignUpOrLogin(code: String) {
        self.smsCodeForSignUpOrLogin = code
    }
    public func grabSmsCodeForSignUpOrLogin() -> String? {
        return self.smsCodeForSignUpOrLogin
    }
    
    private var profilePhotoChanged: UIImage?
    public func letProfilePhotoChanged(photo: UIImage) {
        self.profilePhotoChanged = photo
    }
    public func grabProfilePhotoChanged() -> UIImage? {
        return self.profilePhotoChanged
    }
    public func resetProfilePhotoChanged() {
        self.profilePhotoChanged = nil
    }
    
    private var amountOfOrder: Double?
    public func letAmountOfOrder(amount: Double) {
        self.amountOfOrder = Double(round(amount*100)/100)
    }
    public func grabAmountOfOrder() -> Double {
        return self.amountOfOrder!
    }
    public func resetAmountOfOrder() {
        self.amountOfOrder = nil
    }
    
    private var cardHtml: String?
    public func letCardHtml(html: String) {
        self.cardHtml = html
    }
    public func grabCardHtml() -> String {
        return self.cardHtml!
    }
    public func resetCardHtml() {
        self.cardHtml = nil
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
