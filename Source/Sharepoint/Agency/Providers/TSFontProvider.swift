//
//  FontProvider.swift
//  Taksim
//
//  Created by Can Özcan on 10.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

open class TSFontProvider: CoreFontProvider {
    
    private var regularSmaller: UIFont?
    /// Open Sans / Size: 12
    ///
    /// - Returns: Open Sans / Size: 12
    public func getRegularSmaller() -> UIFont {
        
        guard regularSmaller != nil else {
            regularSmaller = UIFont(name: "OpenSans", size: 12)
            return regularSmaller!
        }
        
        return regularSmaller!
        
    }
    
    private var regularSmall: UIFont?
    /// Open Sans / Size: 14
    ///
    /// - Returns: Open Sans / Size: 14
    public func getRegularSmall() -> UIFont {
        
        guard regularSmall != nil else {
            regularSmall = UIFont(name: "OpenSans", size: 14)
            return regularSmall!
        }
        
        return regularSmall!
        
    }
    
    private var regularMedium: UIFont?
    /// Open Sans / Size: 16
    ///
    /// - Returns: Open Sans / Size: 16
    public func getRegularMedium() -> UIFont {
        
        guard regularMedium != nil else {
            regularMedium = UIFont(name: "OpenSans", size: 16)
            return regularMedium!
        }
        
        return regularMedium!
        
    }
    
    private var semiboldMedium: UIFont?
    /// Open Sans Semibold / Size: 16
    ///
    /// - Returns: Open Sans Semibold / Size: 16
    public func getSemiboldMedium() -> UIFont {
        
        guard semiboldMedium != nil else {
            semiboldMedium = UIFont(name: "OpenSans-Semibold", size: 16)
            return semiboldMedium!
        }
        
        return semiboldMedium!
        
    }
    
    private var semiboldMid: UIFont?
    /// Open Sans Semibold / Size: 18
    ///
    /// - Returns: Open Sans Semibold / Size: 18
    public func getSemiboldMid() -> UIFont {
        
        guard semiboldMid != nil else {
            semiboldMid = UIFont(name: "OpenSans-Semibold", size: 18)
            return semiboldMid!
        }
        
        return semiboldMid!
        
    }
    
    private var semiboldLarge: UIFont?
    /// Open Sans Semibold / Size: 20
    ///
    /// - Returns: Open Sans Semibold / Size: 20
    public func getSemiboldLarge() -> UIFont {
        
        guard semiboldLarge != nil else {
            semiboldLarge = UIFont(name: "OpenSans-Semibold", size: 20)
            return semiboldLarge!
        }
        
        return semiboldLarge!
        
    }
    
    private var semiboldLargest: UIFont?
    /// Open Sans Semibold / Size: 27
    ///
    /// - Returns: Open Sans Semibold / Size: 27
    public func getSemiboldLargest() -> UIFont {
        
        guard semiboldLargest != nil else {
            semiboldLargest = UIFont(name: "OpenSans-Semibold", size: 27)
            return semiboldLargest!
        }
        
        return semiboldLargest!
        
    }
    
    private var semiboldBiggest: UIFont?
    /// Open Sans Semibold / Size: 30
    ///
    /// - Returns: Open Sans Semibold / Size: 30
    public func getSemiboldBiggest() -> UIFont {
        
        guard semiboldBiggest != nil else {
            semiboldBiggest = UIFont(name: "OpenSans-Semibold", size: 30)
            return semiboldBiggest!
        }
        
        return semiboldBiggest!
        
    }
    
    private var lightSmall: UIFont?
    /// Open Sans Light / Size: 14
    ///
    /// - Returns: Open Sans Light / Size: 14
    public func getLightSmall() -> UIFont {
        
        guard lightSmall != nil else {
            lightSmall = UIFont(name: "OpenSans-Light", size: 14)
            return lightSmall!
        }
        
        return lightSmall!
        
    }
    
    private var lightMedium: UIFont?
    /// Open Sans Light / Size: 16
    ///
    /// - Returns: Open Sans Light / Size: 16/*
    public func getLightMedium() -> UIFont {
        
        guard lightMedium != nil else {
            lightMedium = UIFont(name: "OpenSans-Light", size: 16)
            return lightMedium!
        }
        
        return lightMedium!
        
    }
    
}
