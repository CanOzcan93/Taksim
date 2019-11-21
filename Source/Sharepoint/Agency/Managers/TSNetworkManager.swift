//
//  TSNetworkManager.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core
import SwiftyJSON
import ReactiveObjC
import Alamofire

public class TSNetworkManager: CoreNetworkManager, SRWebSocketDelegate {
    
    let voipSpecName = "VoipTaksim"
    var reConnectTime: TimeInterval = 0
    var readyState: SRReadyState = SRReadyState.CLOSED
    var disposable: RACDisposable!

    public var connected: Action?
    public var receiveMessageString: ActionWith<String>?
    public var registerResult: ActionWith<Bool>?
    public var callOutResult: ActionWith<Bool>?
    public var receiveCallOutResult: Action?
    public var hangUpResult: Action?
    public var pongResult: Action?
    public var receiveMessageData: ActionWith<Data>?
    public var receiveVoice: ActionWith<Data>?
    public var didFail: ActionWith<Error>?
    public var didClose: ActionWith<(Int,String?)>?
    
    public func defaultSocket() -> SRWebSocket? {
        return getSocket(spec: voipSpecName)
    }

    public func open() {
        guard let definedSocket = defaultSocket() else {
            let request = URLRequest(url: NSURL(string: "ws://94.101.81.210:2835/im/passenger")! as URL , cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
            let undefinedSocket = SRWebSocket(urlRequest: request)
            undefinedSocket.delegate = self
            self.setSocket(socket: undefinedSocket, spec: voipSpecName)
            undefinedSocket.open()
            self.disposable = RACSignal<AnyObject>.interval(30, on: RACScheduler(priority: RACSchedulerPriorityDefault)).repeat().subscribeNext({ (date) in
                self.ping()
            })
            self.readyState = undefinedSocket.readyState
            return
        }
        definedSocket.open()
        self.disposable = RACSignal<AnyObject>.interval(30, on: RACScheduler(priority: RACSchedulerPriorityDefault)).repeat().subscribeNext({ (date) in
            self.ping()
        })
        self.readyState = definedSocket.readyState
        
    }
    

    public func close() {
        guard let definedSocket = defaultSocket() else {
            return
        }
        self.disposable.dispose()
        definedSocket.close()
        definedSocket.delegate = nil
        deleteSocket(spec: voipSpecName)
    }

    public func reOpen() {
        self.close()
        if (reConnectTime > 64){
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (reConnectTime)) {
            self.deleteSocket(spec: self.voipSpecName)
            self.open()
        }

        if(reConnectTime == 0){
            reConnectTime = 2
        } else {
            reConnectTime *= 2
        }

    }

    public func sendString(parameters: String) {
        if let definedSocket = defaultSocket() {
            if definedSocket.readyState == .OPEN {
                do {
                    try definedSocket.send(string: parameters)
                } catch let error {
                    print("Web Socket Send String Error: \(error)\n When send this: \(parameters)")
                }
                
            }
            else if definedSocket.readyState == .CONNECTING {
                reOpen()
            }
        }
        else {
            reOpen()
        }
    }

    public func sendData(data: NSData) {
        if let definedSocket = defaultSocket() {
            if definedSocket.readyState == .OPEN {
                do {
                    try definedSocket.send(data: data as Data)
                }
                catch let error {
                    print("Web Socket Send Data Error: \(error) When send this: \(data)")
                }
            }
            else if definedSocket.readyState == .CONNECTING {
                reOpen()
            }
        }
        else {
            reOpen()
        }
    }
    
    public func webSocketDidOpen(_ webSocket: SRWebSocket) {
        reConnectTime = 0
        self.connected?()
        self.readyState = webSocket.readyState
    }
    
    public func webSocket(_ webSocket: SRWebSocket, didReceivePingWith data: Data?) {
        
    }
    
    public func webSocket(_ webSocket: SRWebSocket, didReceivePong pongData: Data?) {
        
    }
    
    public func webSocket(_ webSocket: SRWebSocket, didReceiveMessageWith string: String) {
        receiveMessageString?(string)
        var dict: JSON = JSON(parseJSON: string)

        if (dict["cmd"].stringValue == "ws.im.online"){
            registerResult?(dict["result"].intValue == 0)
        }
        else if (dict["cmd"].stringValue == "ws.im.accept" || dict["cmd"].stringValue == "ws.im.refuse") {
            callOutResult?(dict["cmd"].stringValue == "ws.im.accept")
        }
        else if (dict["cmd"].stringValue == "ws.im.call") {
            receiveCallOutResult?()
        }
        else if (dict["cmd"].stringValue == "ws.im.hangup") {
            hangUpResult?()
        }
        else if (dict["cmd"].stringValue == "ws.im.pong") {
            pongResult?()
        }
        else {
            print(dict["cmd"].stringValue)
        }
    }
    
    public func webSocket(_ webSocket: SRWebSocket, didReceiveMessageWith data: Data) {
        receiveMessageData?(data)
        receiveVoice?(data)
    }
    
    public func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
        didFail?(error)
        readyState = defaultSocket()!.readyState
    }
    
    public func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
        didClose?((code,reason))
        readyState = defaultSocket()!.readyState
    }
    

    public func registerWithOrderId(orderId: String, carNo: String, mdtId: String) {

        let jsonDict = JSON(
            ["cmd": "ws.im.online",
            "data": [
                "orderId": orderId,
                "carNo": carNo,
                "mdtId": mdtId
                ]]
        )

        self.sendString(parameters: jsonToString(json: jsonDict))

    }

//    public func writeOff() {
//        if self.disposable.isDisposed {
//            self.disposable.dispose()
//        }
//
//        self.defaultSocket()?.close()
//    }

    public func callOut() {
        let jsonDict = JSON(["cmd": "ws.im.call"])
        self.sendString(parameters: jsonToString(json: jsonDict))
    }

    public func receiveCallOut(accept: Bool) {
        let jsonDict = JSON(["cmd": accept ? "ws.im.accept" : "ws.im.refuse"])
        self.sendString(parameters: jsonToString(json: jsonDict))
    }

    public func hangUp() {
        let jsonDict = JSON(["cmd": "ws.im.hangup"])
        self.sendString(parameters: jsonToString(json: jsonDict))
    }


    public func ping() {
        let jsonDict = JSON(
            ["cmd": "ws.im.ping"]
        )
        self.sendString(parameters: jsonToString(json: jsonDict))
    }

    public func sendVoice(data: Data) {
        self.sendData(data: data as NSData)
    }

    private func jsonToString(json:JSON) -> String {
        guard let str = json.rawString(.utf8, options: .prettyPrinted) else {
            return ""
        }
        let newStr = str.replacingOccurrences(of: " ", with: "")
        let newestStr = newStr.replacingOccurrences(of: "\n", with: "")
        return newestStr
    }
    
    public static func multiPartPostWithImagesPublic(url: String, parameters: [String:Any], headers:[String:String], photos:[String:UIImage]?, completion: @escaping (JSON, [AnyHashable : Any]?)->()) {
        
        var jsonDict = JSON()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key,value) in parameters {
                
                if JSONSerialization.isValidJSONObject(value) {
                    let data = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    if let jsonString = String(data: data, encoding: .utf8) {
                        multipartFormData.append(jsonString.data(using: .utf8)!, withName: key)
                    }
                } else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            if photos != nil {
                for (key, photo) in photos! {
                    multipartFormData.append(photo.jpegData(compressionQuality: 0.2)!, withName: key, fileName: "\(key).jpg", mimeType: "image/*")
                }
            }
            
        }, to: url, headers: headers ) { (result) in
            switch result {
            case .success(let upload,let a,let b):
                upload.uploadProgress { progress in
                    print("\(progress) \n")
                }
                upload.responseJSON { (response) in
                    if let jsonnable = response.result.value {
                        jsonDict = JSON(jsonnable)
                        completion(jsonDict, response.response?.allHeaderFields)
                    }
                }
            case .failure(let encodingError):
                break
            }
        }
        
    }
    
    public static func upload( url : String ,
                        parameter : [String : Any] = [:],
                        headers:[String:String],
                        arrayImage : [String : UIImage],
                        shouldShowHud : Bool = true,
                        completionHandler : @escaping (_ result : NSDictionary , _ status : Bool) -> Void )
    {
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameter{
                if JSONSerialization.isValidJSONObject(value) {
                    let data = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    if let jsonString = String(data: data, encoding: .utf8) {
                        multipartFormData.append(jsonString.data(using: .utf8)!, withName: key)
                    }
                } else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            for (key, value) in arrayImage {
                if let imageData = value.jpegData(compressionQuality: 0.2)  {
                    multipartFormData.append(imageData , withName: key, fileName: "\(key).jpeg", mimeType: "image/*")
                }
            }
        }, to: url, method: .post, headers : headers, encodingCompletion: { encodingResult in
            
            switch encodingResult{
            case .success(let upload, _, _):
                print("Upload Progress \(upload.uploadProgress.completedUnitCount) '\' \(upload.uploadProgress.totalUnitCount)")
                
                upload.responseJSON {  response in
                    if let JSON = response.result.value {
//                        let status = (JSON as! NSDictionary)["status"] as? Bool
                        completionHandler(JSON as! NSDictionary , true)
                    } else  {
                        let result : NSDictionary = ["message" : "Request Time out, please refresh again." as Any]
                        completionHandler( result as NSDictionary , false)
                    }
                }
                break
            case .failure:
                let result : NSDictionary = ["message" : "Request Time out, please refresh again." ]
                completionHandler( result as NSDictionary , false)
                break
            }
        }
        )
    }
    
}




//import Core
//import SwiftWebSocket
//import SwiftyJSON
//
//public class TSNetworkManager: CoreNetworkManager, WebSocketDelegate {
//
//    let voipSpecName = "VoipTaksim"
//    var reConnectTime: TimeInterval = 0
//    var readyState: WebSocketReadyState = WebSocketReadyState.closed
//
//    public var connected: Action?
//    public var receiveMessageString: ActionWith<String>?
//    public var registerResult: ActionWith<Bool>?
//    public var callOutResult: ActionWith<Bool>?
//    public var receiveCallOutResult: Action?
//    public var hangUpResult: Action?
//    public var pongResult: Action?
//    public var receiveMessageData: ActionWith<Data>?
//    public var receiveVoice: ActionWith<Data>?
//    public var didFail: ActionWith<NSError>?
//    public var didClose: ActionWith<(Int,String)>?
//
//    public func defaultSocket() -> WebSocket? {
//        return getSocket(spec: voipSpecName)
//    }
//
//
//    public func open() {
//        guard let definedSocket = defaultSocket() else {
//            let request = URLRequest(url: NSURL(string: "ws://94.101.81.210:2835/im/passenger")! as URL , cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
//            let undefinedSocket = WebSocket(request: request)
//            undefinedSocket.delegate = self
//            undefinedSocket.services = [.VoIP,.Background]
//            undefinedSocket.open()
//            setSocket(socket: undefinedSocket, spec: voipSpecName)
//            self.ping()
//            return
//        }
//        definedSocket.open()
//        self.ping()
//    }
//
//    public func close() {
//        guard let definedSocket = defaultSocket() else {
//            return
//        }
//        definedSocket.close()
//        definedSocket.delegate = nil
//        deleteSocket(spec: voipSpecName)
//    }
//
//    public func reOpen() {
//        self.close()
//        if (reConnectTime > 64){
//            return
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + (reConnectTime)) {
//            self.deleteSocket(spec: self.voipSpecName)
//            self.open()
//        }
//
//        if(reConnectTime == 0){
//            reConnectTime = 2
//        } else {
//            reConnectTime *= 2
//        }
//
//    }
//
//    public func sendString(parameters: String) {
//        if let definedSocket = defaultSocket() {
//            if definedSocket.readyState == .open {
//                definedSocket.send(parameters)
//            }
//            else if definedSocket.readyState == .connecting {
//                reOpen()
//            }
//        }
//        else {
//            reOpen()
//        }
//    }
//
//    public func sendData(data: NSData) {
//        if let definedSocket = defaultSocket() {
//            if definedSocket.readyState == .open {
//                definedSocket.send(data: data as Data)
//            }
//            else if definedSocket.readyState == .connecting {
//                reOpen()
//            }
//        }
//        else {
//            reOpen()
//        }
//    }
//
//    public func webSocketOpen() {
//        reConnectTime = 0
//        self.connected?()
//        if let definedSocket = defaultSocket() {
//            readyState = definedSocket.readyState
//        }
//    }
//
//    public func webSocketMessageText(_ text: String) {
//        receiveMessageString?(text)
//        var dict: JSON = JSON(parseJSON: text)
//
//        if (dict["cmd"].stringValue == "ws.im.online"){
//            registerResult?(dict["result"].intValue == 0)
//        }
//        else if (dict["cmd"].stringValue == "ws.im.accept" || dict["cmd"].stringValue == "ws.im.refuse") {
//            callOutResult?(dict["cmd"].stringValue == "ws.im.accept")
//        }
//        else if (dict["cmd"].stringValue == "ws.im.call") {
//            receiveCallOutResult?()
//        }
//        else if (dict["cmd"].stringValue == "ws.im.hangup") {
//            hangUpResult?()
//        }
//        else if (dict["cmd"].stringValue == "ws.im.pong") {
//            pongResult?()
//        }
//        else {
//            print(dict["cmd"].stringValue)
//        }
//    }
//
//    public func webSocketMessageData(_ data: Data) {
//        receiveMessageData?(data)
//        receiveVoice?(data)
//    }
//
//    public func webSocketError(_ error: NSError) {
//        didFail?(error)
//        readyState = defaultSocket()!.readyState
//    }
//
//    public func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
//        didClose?((code,reason))
//        readyState = defaultSocket()!.readyState
//    }
//
//
//
//    public func registerWithOrderId(orderId: String, carNo: String, mdtId: String) {
//
//        let jsonDict = JSON(
//            ["cmd": "ws.im.online",
//            "data": [
//                "orderId": orderId,
//                "carNo": carNo,
//                "mdtId": mdtId
//                ]]
//        )
//
//        defaultSocket()?.send(jsonToString(json: jsonDict))
//
//    }
//
////    public func writeOff() {
////        guard let definedSocket = defaultSocket() else {
////            return
////        }
////    }
//
//    public func callOut() {
//        let jsonDict = JSON(["cmd": "ws.im.call"])
//        defaultSocket()?.send(text: jsonToString(json: jsonDict))
//    }
//
//    public func receiveCallOut(accept: Bool) {
//        let jsonDict = JSON(["cmd": accept ? "ws.im.accept" : "ws.im.refuse"])
//        defaultSocket()?.send(text: jsonToString(json: jsonDict))
//    }
//
//    public func hangUp() {
//        let jsonDict = JSON(["cmd": "ws.im.hangup"])
//        defaultSocket()?.send(text: jsonToString(json: jsonDict))
//    }
//
//
//    public func ping() {
//        let jsonDict = JSON(
//            ["cmd": "ws.im.ping"]
//        )
//        defaultSocket()?.send(text: jsonToString(json: jsonDict))
//    }
//
//    public func sendVoice(data: Data) {
//        defaultSocket()?.send(data: data)
//    }
//
//    private func jsonToString(json:JSON) -> String {
//        guard let str = json.rawString(.utf8, options: .prettyPrinted) else {
//            return ""
//        }
//        let newStr = str.replacingOccurrences(of: " ", with: "")
//        let newestStr = newStr.replacingOccurrences(of: "\n", with: "")
//        return newestStr
//    }
//
//}
