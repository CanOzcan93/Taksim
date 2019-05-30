//
//  TSPersistentStorage.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

public class TSPersistentStorage: CorePersistentStorage {
    
    public let phoneNumberKey = "Taksim_PhoneNumber" + "\("Taksim_PhoneNumber".hash)"
    public let tokenKey = "Taksim_Token" + "\("Taksim_Token".hash)"
    
}
