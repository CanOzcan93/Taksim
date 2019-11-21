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
import NetworkExtension

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
    
//    private let baseURL = "http://58.250.161.107:1700/AppService/"
    private let baseURL = "http://94.101.81.210:48080/AppService/"
    private var timer: Timer!
    private var vehicle: Vehicle!
    private var shouldBeTracking: Bool = false
    public func startTrackingVehicles(coordinate: @escaping () -> CoreCoordinate, radius: UInt, token: String, completion: @escaping Action) {
        
        self.shouldBeTracking = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
         
            if (self.shouldBeTracking) {
            
                let url = "\(self.baseURL)GetUsableCars.do"
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
     
        let url = "\(baseURL)GetUsableCars.do"
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
        let url = "\(baseURL)CheckVersion.do"
        let data = "jsonParam={\"type\": 1,\"os\": 1,\"version\":1}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
        
    }
    
    public func checkToken(token: String, completion: @escaping (JSON,String?)->()) {
        let url = "\(baseURL)CheckToken.do"
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
        let url = "\(baseURL)GetOrderInfo.do"
        let data = "jsonParam={orderId:\"\(orderID)\", i18n:\"en_US\"}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
        
    }
    
    public func getVerifyCode(mobilePhone: String, completion: @escaping (JSON)->()) {
        let url = "\(baseURL)GetVerifyCode.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", debug:1, type:1}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
    }
    
    public func customerLogin(mobilePhone: String,verifyCode: UInt, completion: @escaping (JSON, String?)->()) {
        let url = "\(baseURL)CustomerLogin.do"
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
        
//        let url = "\(baseURL)UpdateCustomerInfo.do"
////        let url = "https://postman-echo.com/post"
//        let header = ["_token": token]
//        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
//                "mobile": mobilePhone,
//                "customerInfo": [
//                    "age": customerInfo.age,
//                    "compAddrName": customerInfo.compAddrName,
//                    "compLat": customerInfo.companyLocation.coordinate.latitude,
//                    "compLon": customerInfo.companyLocation.coordinate.longitude,
//                    "compName": customerInfo.compName,
//                    "email": customerInfo.email,
//                    "gender": customerInfo.gender.rawValue,
//                    "guarderPhone": customerInfo.guarderPhone,
//                    "homeAddrName": customerInfo.homeAddrName,
//                    "homeLat": customerInfo.homeLocation.coordinate.latitude,
//                    "homeLon": customerInfo.homeLocation.coordinate.longitude,
//                    "level": customerInfo.level,
//                    "nickName": customerInfo.nickname,
//                    "occupation": customerInfo.occupation,
//                    "trade": customerInfo.trade
//                ]
//            ]
//        ]
//
////        if photo != nil {
////            TSNetworkManager.upload(url: url, parameter: parameters, headers: header, arrayImage: ["photo": photo!]) { (dict, ok) in
////
////                if ok {
////                    let json = JSON(dict)
////                    completion(json)
////                }
////            }
////        } else {
////            TSNetworkManager.upload(url: url, parameter: parameters, headers: header, arrayImage: [:]) { (dict, ok) in
////                print(dict, ok)
////                if ok {
////                    let json = JSON(dict)
////                    completion(json)
////                }
////            }
////        }
//
//
//        if photo != nil {
//            TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: ["photo": photo!]) { (json, headers) in
////                print(json)
//                completion(json)
//            }
//        } else {
//            TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, headers) in
////                print(json)
//                completion(json)
//            }
//        }
        
        let url = "\(baseURL)UpdateCustomerInfo.do"
        var customerInfoJson = "age:\"\(customerInfo.age)\", compAddrName: \"\(customerInfo.compAddrName)\", compLat: \(customerInfo.companyLocation.coordinate.latitude),  compLon:\(customerInfo.companyLocation.coordinate.longitude), compName: \"\(customerInfo.compName)\", email:\"\(customerInfo.email)\", gender: \(customerInfo.gender.rawValue), guarderPhone: \"\(customerInfo.guarderPhone)\", homeAddrName: \"\(customerInfo.homeAddrName)\", homeLat:\(customerInfo.homeLocation.coordinate.latitude), homeLon: \(customerInfo.homeLocation.coordinate.longitude), level: \(customerInfo.level), nickName: \"\(customerInfo.nickname)\", occupation:\"\(customerInfo.occupation)\", trade: \"\(customerInfo.trade)\""
        let data = "jsonParam={mobile:\"\(mobilePhone)\", customerInfo:{\(customerInfoJson)}}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
        
    }
    
    public func changeMobile(mobilePhone: String, newMobilePhone: String, completion: @escaping (JSON)->()) {
        let url = "\(baseURL)ChangeMobile.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", new Mobile:\"\(newMobilePhone)\", debug:1}"

        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
    }
    
    public func verifyMobile(mobilePhone: String,verifyCode: UInt, completion: @escaping (JSON)->()) {
        let url = "\(baseURL)VerifyMobile.do"
        let data = "jsonParam={mobile:\"\(mobilePhone)\", verifyCode:\"\(verifyCode)\"}"
        
        TSNetworkManager.post(url: url, body: data) { (json, header) in
            completion(json)
        }
    }
    
    public func getFeeStrategies(token: String, completion: @escaping (JSON)->()){
        let url = "\(baseURL)GetFeeStrategies.do"
        let data = "jsonParam={}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func createOrder(mobilePhone: String, token: String, order:Order, completion: @escaping (JSON)->()){
        let url = "\(baseURL)CreateOrder.do"
        let orderJson = "orderTime:\"\(order.orderTime)\", orderAddrName:\"\(order.orderAddrName)\", orderLon:\(order.orderCoordinate.coordinate.longitude), orderLat:\(order.orderCoordinate.coordinate.latitude), destAddrName:\"\(order.destAddrName)\", destLon:\(order.destinationCoordinate.coordinate.longitude), destLat:\(order.destinationCoordinate.coordinate.latitude), orderType:\(order.orderType), remarks:\"\(order.remarks)\", carType:\(order.carType), isShared:\(order.isShared)"
        let data = "jsonParam={mobile: \"\(mobilePhone)\", \(orderJson)}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func getOrderTracking(orderID: UInt, token: String, completion: @escaping (JSON)->()){
        let url = "\(baseURL)GetOrderTracking.do"
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
        let url = "\(baseURL)EvaluateOrder.do"
        let header = ["_token": token]
        //        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
        //            "orderId": "\(orderID)",
        //            "carNo": carNo,
        //            "driverNo": driverNo,
        //            "evaluation": "\(evaluation)"
        //            ]
        //        ]
        //
        //
        //        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: header, photos: nil) { (json, header) in
        //            completion(json)
        //        }
        
        let orderJson = "orderId:\(orderID), carNo: \(carNo), driverNo: \(driverNo), evaluation: \(evaluation)"
        let data = "jsonParam={\(orderJson)}"
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func cancelOrder(orderID: UInt, reason: UInt, token: String, completion: @escaping (JSON)->()) {
        
        let url = "\(baseURL)CancelOrder.do"
        let header = ["_token": token]
//        let parameters: Dictionary<String,Any> = [ "jsonParam" : [
//            "orderId": "\(orderID)",
//            "reason": reason
//            ]
//        ]
        
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
        let url = "\(baseURL)GetCustomerHistoryOrders.do"
        let data = "jsonParam={mobile:\"\(mobile)\", page:\(page), num:\(num)}"
        let header = ["_token": token]
        
        TSNetworkManager.postWithHeader(url: url, body: data, headers: header) { (json, header) in
            completion(json)
        }
    }
    
    public func getCustomerAddress(userID: UInt, token: String, completion: @escaping (JSON)->()) {
        let url = "\(baseURL)GetCustomerAddress.do"
//        let url = "https://postman-echo.com/post"
        let header = ["_token": token, "accept-encoding":"gzip, deflate", "user-agent": "PostmanRuntime/7.15.2"]
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
        let url = "\(baseURL)AddCustomerAddress.do"
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
        let url = "\(baseURL)RemoveCustomerAddress.do"
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
    
    public func addCreditCard(
        cardName: String,
        cardNumber: String,
        expiryMonth:UInt,
        expiryYear:UInt,
        cvv:UInt,
        email: String,
        nameAndSurname: String,
        userPhone: String,
        userID: UInt,
        cardCount: UInt,
        utoken: String? = nil,
        completion: @escaping (String)->()) {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomThree = String((0..<3).map{ _ in letters.randomElement()! })
        
//        let url = "https://www.paytr.com/odeme"
        let url = "https://postman-echo.com/post"
        
        let ip = UIDevice.current.ipAddress()
        let merchant_oid = "scc\(userID)\(randomThree)\(String(format: "%02d", cardCount))"
        
        let merchant_id = "135195"
        let merchant_key = "FutXD1e4ZWH7xZBu"
        let merchant_salt = "FsKUEZXUc39dtcfk"
        
        let testMode = 1
        let non3D = 0
        let debugOn = 0
        let installmentCount = 0
        let non3DTestFailed = 0
        let storeCard = 1
        
        let crypto = EasyCrypt(secret: merchant_key, algorithm: .sha256)
        
        var parameters: Dictionary<String,Any> = [
            "cc_owner": cardName,
            "card_number": cardNumber,
            "expiry_month": expiryMonth,
            "expiry_year": expiryYear,
            "cvv": cvv,
            "merchant_id": merchant_id,
            "user_ip": ip!,
            "merchant_oid": merchant_oid,
            "email": email,
            "payment_type": "card",
            "payment_amount": "1.00",
            "test_mode": testMode,
            "non_3d": non3D,
            "merchant_ok_url": "https://google.com",
            "merchant_fail_url": "https://facebook.com",
            "user_address": "Altıntepsi, Öztekin Cd. No:54, 34035 Bayrampaşa/İstanbul",
            "user_name": nameAndSurname,
            "user_phone": userPhone,
            "user_basket": [["kart kaydetme taksim", "1.00", 1]],
            "debug_on": debugOn,
            "installment_count": installmentCount,
            "paytr_token": crypto.hash("\(merchant_id)\(ip)\(merchant_oid)\(email)1.00card\(installmentCount)\(testMode)\(non3D)\(merchant_salt)"),
            "non3d_test_failed": non3DTestFailed,
            "store_card": storeCard,
        ]
        if let definedToken = utoken {
            if definedToken != "" {
                parameters["utoken"] = definedToken
            }
        }
        TSNetworkManager.multiPartPostWithImages(url: url, parameters: parameters, headers: [:], photos: nil) { (string:String, header) in
            completion(string)
        }
    }
    
    public func checkCreditCard(binNumber: String, completion: @escaping (JSON)->()) {
        
        let url = "https://www.paytr.com/odeme/api/bin-detail"
        
        let merchant_id = "135195"
        let merchant_key = "FutXD1e4ZWH7xZBu"
        let merchant_salt = "FsKUEZXUc39dtcfk"
        
        let crypto = EasyCrypt(secret: merchant_key, algorithm: .sha256)
        
        var parameters: Dictionary<String,Any> = [
            "merchant_id": merchant_id,
            "bin_number": binNumber,
            "paytr_token": crypto.hash("\(binNumber)\(merchant_id)\(merchant_salt)"),
        ]
        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: [:], photos: nil) { (json, header) in
            completion(json)
        }
    }
    
    public func creditCardList(uToken: String, completion: @escaping (JSON)->()) {
        
        let url = "https://www.paytr.com/odeme/api/bin-detail"
        
        let merchant_id = "135195"
        let merchant_key = "FutXD1e4ZWH7xZBu"
        let merchant_salt = "FsKUEZXUc39dtcfk"
        
        let crypto = EasyCrypt(secret: merchant_key, algorithm: .sha256)
        
        var parameters: Dictionary<String,Any> = [
            "merchant_id": merchant_id,
            "utoken": uToken,
            "paytr_token": crypto.hash("\(uToken)\(merchant_id)\(merchant_salt)"),
        ]
        TSNetworkManager.multiPartPostWithImagesPublic(url: url, parameters: parameters, headers: [:], photos: nil) { (json, header) in
            completion(json)
        }
        
    }
    
    
        
//    private func getIPAddress() -> String? {
//        var address: String?
//        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
//        if getifaddrs(&ifaddr) == 0 {
//            var ptr = ifaddr
//            while ptr != nil {
//                defer { ptr = ptr?.pointee.ifa_next }
//                
//                let interface = ptr?.pointee
//                let addrFamily = interface?.ifa_addr.pointee.sa_family
//                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//                    
//                    if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
//                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
//                        address = String(cString: hostname)
//                    }
//                }
//            }
//            freeifaddrs(ifaddr)
//        }
//        return address
//    }
}
