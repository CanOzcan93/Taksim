//
//  TSApiManager.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core
import SwiftyJSON
import Alamofire

public class TSApiManager: CoreApiManager {
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    private var repository: TSRepository!
    
    private var manager: TSManager!
    
    private var eventManager: TSEventManager!
    private var networkManager: TSNetworkManager!
    
    private var dataStorage: TSDataStorage!
    private var persistentStorage: TSPersistentStorage!
    private var exchangeFlow: TSExchangeFlow!
    
    public func injectDependencies() {

        sharepoint = TSSharepoint.getInstance()
        agency = sharepoint.agency
        repository = sharepoint.repository
        manager =  agency.manager
        eventManager = manager.eventManager!
        networkManager = manager.networkManager!
        
        dataStorage = repository.dataStorage
        persistentStorage = repository.persistentStorage
        exchangeFlow = repository.exchangeFlow
        
    }
    
    
    private var timer: Timer!
    private var vehicle: Vehicle!
    private var shouldBeTracking: Bool = false
    public func startTrackingVehicles(coordinate: @escaping () -> CoreCoordinate, radius: UInt, token: String, completion: @escaping Action) {
        
        self.shouldBeTracking = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
         
            if (self.shouldBeTracking) {
            
                let url = "http://94.101.81.210:48080/AppService/GetUsableCars.do"
                let data = "jsonParam={\"lon\":\(coordinate().coordinate.longitude), \"lat\":\(coordinate().coordinate.latitude), \"radius\":\(radius)}"
                let header = ["_token": token]
                
                TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
                    
                    self.dataStorage.clearAvailableVehicles()
                    
                    if (self.shouldBeTracking) {
                        
                        for jsonVehicle in json["cars"].arrayValue {
                            
                            self.vehicle = Vehicle()
                            self.vehicle.no = jsonVehicle["carNo"].stringValue
                            self.vehicle.type = jsonVehicle["carType"].uIntValue
                            self.vehicle.coordinate = CoreCoordinate(latitude: jsonVehicle["lat"].doubleValue, longitude: jsonVehicle["lon"].doubleValue)
                            self.vehicle.direction = jsonVehicle["direction"].uIntValue
                            
                            self.dataStorage.storeAvailableVehicle(vehicle: self.vehicle)
                            
                        }
                        
                        completion()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    public func stopTrackingVehicles() {
        
        self.shouldBeTracking = false
        
        if (self.timer != nil) {
            self.timer.invalidate()
            self.timer = nil
        }
        
    }
    public func fetchVehicles(coordinate: @escaping () -> CoreCoordinate, radius: UInt, token: String, completion: @escaping Action) {
     
        let url = "http://94.101.81.210:48080/AppService/GetUsableCars.do"
        let data = "jsonParam={\"lon\":\(coordinate().coordinate.longitude), \"lat\":\(coordinate().coordinate.latitude), \"radius\":\(radius)}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            
            self.dataStorage.clearAvailableVehicles()
            
            for jsonVehicle in json["cars"].array! {
                
                self.vehicle = Vehicle()
                self.vehicle.no = jsonVehicle["carNo"].stringValue
                self.vehicle.type = jsonVehicle["carType"].uIntValue
                self.vehicle.coordinate = CoreCoordinate(latitude: jsonVehicle["lat"].doubleValue, longitude: jsonVehicle["lon"].doubleValue)
                self.vehicle.direction = jsonVehicle["direction"].uIntValue
                
                self.dataStorage.storeAvailableVehicle(vehicle: self.vehicle)
                
            }
            
            completion()
            
        }
        
    }
    
    public func version(completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/CheckVersion.do"
        let data = "jsonParam={\"type\": 1,\"os\": 1,\"version\":1}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
        
    }
    
    public func checkToken(token: String, completion: @escaping (JSON,String?)->()) {
        let url = "http://94.101.81.210:48080/AppService/CheckToken.do"
        let data = "jsonParam={}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            if let headerDefined = header {
                completion(json, headerDefined["_token"] as? String)
            }
            else {
                completion(json, nil)
            }
        }
        
        
    }
    
    public func getOrderInfo(orderID: UInt, completion: @escaping (JSON)->()){
        let url = "http://94.101.81.210:48080/AppService/GetOrderInfo.do"
        let data = "jsonParam={orderId:\"\(orderID)\", i18n:\"en_US\"}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
        
    }
    
    public func getVerifyCode(mobilePhone: String, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/GetVerifyCode.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", debug:1, type:1}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
    }
    
    public func customerLogin(mobilePhone: String,verifyCode: UInt, completion: @escaping (JSON, String?)->()) {
        let url = "http://94.101.81.210:48080/AppService/CustomerLogin.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", verifyCode:\"\(verifyCode)\"}"
        
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            if let headerDefined = header {
                completion(json, headerDefined["_token"] as? String)
            }
            else {
                completion(json, nil)
            }
            
        }
    }
    
    public func updateCustomerInfo(mobilePhone: String, customerInfo: CustomerInfo, token: String, photo: UIImage?, completion: @escaping (JSON)->()) {
        
        let url = "https://portal.taksimizmir.com/AppService/UpdateCustomerInfo.do"
        let header = ["_token": token]
        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
                "mobile": mobilePhone,
                "customerInfo": [
                    "age": customerInfo.age,
                    "compAddrName": customerInfo.compAddrName,
                    "compLat": customerInfo.companyLocation.coordinate.latitude,
                    "compLon": customerInfo.companyLocation.coordinate.longitude,
                    "compName": customerInfo.compName,
                    "email": customerInfo.email,
                    "gender": customerInfo.gender.rawValue,
                    "guarderPhone": customerInfo.guarderPhone,
                    "homeAddrName": customerInfo.homeAddrName,
                    "homeLat": customerInfo.homeLocation.coordinate.latitude,
                    "homeLon": customerInfo.homeLocation.coordinate.longitude,
                    "level": customerInfo.level,
                    "nickName": customerInfo.nickname,
                    "occupation": customerInfo.occupation,
                    "trade": customerInfo.trade
                ]
            ]
        ]
        
        if photo != nil {
            TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: ["photo": photo!]) { (json, headers) in
                completion(json)
            }
        } else {
            TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, headers) in
                completion(json)
            }
        }
    }
    
    public func changeMobile(mobilePhone: String, newMobilePhone: String, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/ChangeMobile.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", new Mobile:\"\(newMobilePhone)\", debug:1}"

        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
    }
    
    public func verifyMobile(mobilePhone: String,verifyCode: UInt, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/VerifyMobile.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", verifyCode:\"\(verifyCode)\"}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
    }
    
    public func getFeeStrategies(token: String, completion: @escaping (JSON)->()){
        let url = "http://94.101.81.210:48080/AppService/GetFeeStrategies.do"
        let data = "jsonParam={}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func createOrder(mobilePhone: String, token: String, order:Order, completion: @escaping (JSON)->()){
        let url = "http://94.101.81.210:48080/AppService/CreateOrder.do"
        let orderJson = "orderTime:\"\(order.orderTime)\", orderAddrName:\"\(order.orderAddrName)\", orderLon:\(order.orderCoordinate.coordinate.longitude), orderLat:\(order.orderCoordinate.coordinate.latitude), destAddrName:\"\(order.destAddrName)\", destLon:\(order.destinationCoordinate.coordinate.longitude), destLat:\(order.destinationCoordinate.coordinate.latitude), orderType:\(order.orderType), remarks:\"\(order.remarks)\", carType:\(order.carType), isShared:\(order.isShared)"
        let data = "jsonParam={mobile: \"\(mobilePhone)\", \(orderJson)}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func getOrderTracking(orderID: UInt, token: String, completion: @escaping (JSON)->()){
        let url = "http://94.101.81.210:48080/AppService/GetOrderTracking.do"
        let data = "jsonParam={orderId:\"\(orderID)\"}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
        
    }
    
    public func getFaq(completion: @escaping (JSON)->()) {
        let url = "http://www.taksimizmir.com/app_content/taksim_sss.json"
        
        TSNetworkManager.getJson(url: url) { (json) in
            completion(json)
        }
    }
    
    private var orderDispatched: Bool!
    private var tripStarted: Bool!
    
    private var onOrderDispatched: Action!
    private var onOrderFailedToDispatch: Action!
    private var onOrderCanceled: Action!
    private var onTripStarted: Action!
    private var onPayment: Action!
    
    public func startTrackingOrder(onSuccess: @escaping Action, onCancel: @escaping Action, onFail: @escaping Action, onTripStarted: @escaping Action, onPayment: @escaping Action) {
        
        self.orderDispatched = false
        self.tripStarted = false
        
        self.onOrderDispatched = onSuccess
        self.onOrderCanceled = onCancel
        self.onOrderFailedToDispatch = onFail
        self.onTripStarted = onTripStarted
        self.onPayment = onPayment
        
        trackOrder()
        
    }
    private func trackOrder() {
        
        getOrderTracking(orderID: dataStorage.grabOrderId()!, token: persistentStorage.recall(key: persistentStorage.tokenKey) as! String ) { res in
            
            let status = res.dictionaryValue["orderStatus"]?.dictionaryValue["orderStatus"]?.intValue
            
            if (status! <= 6) {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self.trackOrder()
                    
                }
                
            } else if (status == 8) {
                
                let carInfo = res.dictionaryValue["carInfo"]!
                let lat = carInfo.dictionaryValue["lat"]?.doubleValue
                let lon = carInfo.dictionaryValue["lon"]?.doubleValue
                
                var vehicle = self.dataStorage.grabDispatchedVehicle()
                
                if (vehicle == nil) {
                    vehicle = Vehicle()
                }
                
                vehicle!.no = carInfo.dictionaryValue["carNo"]?.stringValue
                vehicle!.type = 1
                vehicle!.model = carInfo["carNo"].string
                vehicle!.coordinate = CoreCoordinate(latitude: lat!, longitude: lon!)
                vehicle!.direction = carInfo.dictionaryValue["direction"]?.uIntValue
                
                self.dataStorage.storeDispathedVehicle(vehicle: vehicle)
                
                if (!self.orderDispatched) {
                    self.dataStorage.storeDispatchedDriver(json: res) {
                        self.orderDispatched = true
                        self.onOrderDispatched()
                    }
                }
                
                self.eventManager.shout(key: "dispatchedVehicleUpdated")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self.trackOrder()
                    
                }
                
            } else if (status == 9) {
                
                self.exchangeFlow.letAmountOfOrder(amount: res["feeInfo"]["amount"].doubleValue)
                self.onPayment()
                
            } else if (status == 11) {
                
                self.onOrderCanceled()
                
            } else if (status == 12) {
                
                self.onOrderFailedToDispatch()
                
            } else if (status == 20) {
                
                if (!self.tripStarted) {
                    self.onTripStarted()
                    self.tripStarted = true
                }
                
                if (!self.orderDispatched) {
                    self.dataStorage.storeDispatchedDriver(json: res) {
                        self.orderDispatched = true
                    }
                }
                let carInfo = res.dictionaryValue["carInfo"]!
                let lat = carInfo.dictionaryValue["lat"]?.doubleValue
                let lon = carInfo.dictionaryValue["lon"]?.doubleValue
                
                var vehicle = self.dataStorage.grabDispatchedVehicle()
                
                if (vehicle == nil) {
                    vehicle = Vehicle()
                }
                
                vehicle!.no = carInfo.dictionaryValue["carNo"]?.stringValue
                vehicle!.type = 1
                vehicle!.coordinate = CoreCoordinate(latitude: lat!, longitude: lon!)
                vehicle!.direction = carInfo.dictionaryValue["direction"]?.uIntValue
                
                self.dataStorage.storeDispathedVehicle(vehicle: vehicle)
                
                self.eventManager.shout(key: "dispatchedVehicleUpdated")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self.trackOrder()
                    
                }
                
            }
            
        }
        
    }
    
    
    public func evaluateOrder(orderID: UInt, carNo: String, driverNo:String, evaluation:UInt, token: String, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/EvaluateOrder.do"
        let header = ["_token": token]
        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
            "orderId": "\(orderID)",
            "carNo": carNo,
            "driverNo": driverNo,
            "evaluation": "\(evaluation)"
            ]
        ]

        
        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, header) in
            completion(json)
        }
    }
    
    public func cancelOrder(orderID: UInt, reason: UInt, token: String, completion: @escaping (JSON)->()) {
        
        let url = "http://94.101.81.210:48080/AppService/CancelOrder.do"
        let header = ["_token": token]
//        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
//            "orderId": "\(orderID)",
//            "reason": reason
//            ]
//        ]
//        print("Cancel order\n Token:\(token) \n OrderID:\(orderID)")
//        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, headers) in
//            completion(json)
//        }
        
        let orderJson = "orderId:\(orderID), reason: \(reason)"
        let data = "jsonParam={\(orderJson)}"
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }

    }
    
    public func customerHistoryOrders(mobile: String, page: UInt, num: UInt,token: String,completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/GetCustomerHistoryOrders.do"
        let data = "jsonParam={mobile:\"\(mobile)\", page:\(page), num:\(num)}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func getCustomerAddress(userID: UInt, token: String, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/GetCustomerAddress.do"
        let header = ["_token": token]
//        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
//            "userId": userID
//            ]
//        ]
//
//        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, header) in
//            print("Get Customer Address \(json.rawString()!)")
//            completion(json)
//        }
        
        let orderJson = "userId:\"\(userID)\""
        let data = "jsonParam={\(orderJson)}"

        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func addCustomerAddress(name: String, coordinate: CoreCoordinate, remark: String, address: String, userID: UInt, token: String, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/AddCustomerAddress.do"
        let header = ["_token": token]
//        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
//            "address": address,
//            "lat": coordinate.coordinate.latitude,
//            "lon": coordinate.coordinate.longitude,
//            "name": name,
//            "remark": remark,
//            "userId": userID
//            ]
//        ]
//
//
//        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, header) in
//            completion(json)
//        }
        
        let orderJson = "address:\"\(address)\",lat:\"\(coordinate.coordinate.latitude)\",lon:\"\(coordinate.coordinate.longitude)\",name:\"\(name)\",remark:\"\(remark)\",userId:\"\(userID)\","
        let data = "jsonParam={\(orderJson)}"
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func removeCustomerAddress(addressID: UInt, token: String, completion: @escaping (JSON)->()) {
        let url = "http://94.101.81.210:48080/AppService/RemoveCustomerAddress.do"
        let header = ["_token": token]
//        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
//            "addressId": addressID
//            ]
//        ]
//
//
//        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, header) in
//            completion(json)
//        }
        
        let orderJson = "addressId:\"\(addressID)\""
        let data = "jsonParam={\(orderJson)}"
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    
}
