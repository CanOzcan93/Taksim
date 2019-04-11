//
//  Order.swift
//  Taksim
//
//  Created by Can Özcan on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

open class Order {
    var orderTime: Date = Date()
    var orderAddrName:String = "xxxxxxx"
    var orderCoordinate: CoreCoordinate = CoreCoordinate(latitude: 121.1234, longitude: 31.1234)
    var destAddrName:String = "xxxxxxx"
    var destinationCoordinate: CoreCoordinate = CoreCoordinate(latitude: 121.5678, longitude: 31.5678)
    var orderType:UInt = 0
    var remarks:String = "xxxxxxx"
    var carType:UInt = 1
    var isShared:UInt = 0
}
