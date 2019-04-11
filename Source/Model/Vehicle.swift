//
//  Taxi.swift
//  Taksim
//
//  Created by Can Özcan on 15.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

public class Vehicle: Equatable {
    
    public var no: String!
    public var type: UInt!
    
    public var coordinate: CoreCoordinate!
    public var direction: UInt!
    
    public static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.no == rhs.no
    }
    
}
