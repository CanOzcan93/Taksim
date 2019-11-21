//
//  CustomerInfo.swift
//  Taksim
//
//  Created by Can Özcan on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

enum Gender: UInt {
    case male = 0
    case female = 1
}

open class CustomerInfo: CustomStringConvertible {
    var nickname: String = "Nick"
    var level: UInt = 0
    var gender: Gender = Gender.male
    var age: String = "1980s"
    var trade: String = "Transportation"
    var compName: String = "company name"
    var email: String = ""
    var guarderPhone: String = ""
    var occupation: String = "XXXXX"
    var homeAddrName: String = "XXXXX"
    var homeLocation: CoreCoordinate = CoreCoordinate(latitude: 121.1234, longitude: 31.1234)
    var compAddrName: String = "XXXXXX"
    var companyLocation: CoreCoordinate = CoreCoordinate(latitude: 121.5678, longitude: 31.5678)
    var photo: String = ""
    var userId: UInt = 0
    var profilePicture: UIImage?
    var uToken: String?
    
    public var description: String {
        var description = ""
        
        description += "age: \(self.age)\n"
        description += "compAddrName: \(self.compAddrName)\n"
//        description += "compLocation: \(self.companyLocation)\n"
        description += "compName: \(self.compName)\n"
        description += "email: \(self.email)\n"
        description += "gender: \(self.gender)\n"
        description += "guarderPhone: \(self.guarderPhone)\n"
        description += "homeAddrName: \(self.homeAddrName)\n"
//        description += "homeLocation: \(self.homeLocation)\n"
        description += "level: \(self.level)\n"
        description += "nickName: \(self.nickname)\n"
        description += "occupation: \(self.occupation)\n"
        description += "photo: \(self.photo)\n"
        description += "trade: \(self.trade)\n"
        description += "userId: \(self.userId)\n"
        
        return description
    }
}
