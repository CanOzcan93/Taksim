//
//  TSColorProvider.swift
//  Materials
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

public class TSColorProvider: CoreColorProvider {
    
    private var transparent: UIColor!
    public func getTransparent() -> UIColor {
        
        guard transparent != nil else {
            transparent = UIColor.clear
            return transparent!
        }
        
        return transparent!
        
    }
    
    private var whiteFull: UIColor!
    public func getWhiteFull() -> UIColor {
        
        guard whiteFull != nil else {
            whiteFull = self.hexToUIColor(hexString: "#FFFFFF")
            return whiteFull!
        }
        
        return whiteFull!
        
    }
    
    private var whiteSoft: UIColor!
    public func getWhiteSoft() -> UIColor {
        
        guard whiteSoft != nil else {
            whiteSoft = self.hexToUIColor(hexString: "#F2F2F2").withAlphaComponent(0.6)
            return whiteSoft!
        }
        
        return whiteSoft!
        
    }
    
    private var blackFull: UIColor!
    public func getBlackFull() -> UIColor {
        
        guard blackFull != nil else {
            blackFull = self.hexToUIColor(hexString: "#000000")
            return blackFull!
        }
        
        return blackFull!
        
    }
    
    private var blackSoft: UIColor!
    public func getBlackSoft() -> UIColor {
        
        guard blackSoft != nil else {
            blackSoft = self.hexToUIColor(hexString: "#000000").withAlphaComponent(0.75)
            return blackSoft!
        }
        
        return blackSoft!
        
    }
    
    private var blackSofter: UIColor!
    public func getBlackSofter() -> UIColor {
        
        guard blackSofter != nil else {
            blackSofter = self.hexToUIColor(hexString: "#000000").withAlphaComponent(0.6)
            return blackSofter!
        }
        
        return blackSofter!
        
    }
    
    private var blackSoftest: UIColor!
    public func getBlackSoftest() -> UIColor {
        
        guard blackSoftest != nil else {
            blackSoftest = self.hexToUIColor(hexString: "#000000").withAlphaComponent(0.4)
            return blackSoftest!
        }
        
        return blackSoftest!
        
    }
    
    private var lightBlue: UIColor!
    public func getLightBlue() -> UIColor {
        
        guard lightBlue != nil else {
            
            lightBlue = self.hexToUIColor(hexString: "#33DAF9")
            return lightBlue!
        }
        
        return lightBlue!
        
    }
    
    private var routeBlue: UIColor!
    public func getRouteBlue() -> UIColor {
        
        guard routeBlue != nil else {
            
            routeBlue = self.hexToUIColor(hexString: "#3399FF").withAlphaComponent(0.8)
            return routeBlue!
        }
        
        return routeBlue!
        
    }
    
    private var normalBlue: UIColor!
    public func getNormalBlue() -> UIColor {
        
        guard normalBlue != nil else {
            
            normalBlue = self.hexToUIColor(hexString: "#0D8AFD")
            return normalBlue!
        }
        
        return normalBlue!
        
    }
    
    private var darkGray: UIColor!
    public func getDarkGray() -> UIColor {
        
        guard darkGray != nil else {
            
            darkGray = self.hexToUIColor(hexString: "#4F4F4F")
            return darkGray!
        }
        
        return darkGray!
        
    }
    
    private var grayLight: UIColor!
    public func getGrayLight() -> UIColor {
        
        guard grayLight != nil else {
            grayLight = self.hexToUIColor(hexString: "#BDBDBD")
            return grayLight!
        }
        
        return grayLight!
        
    }
    
    private var grayLighter: UIColor!
    public func getGrayLighter() -> UIColor {
        
        guard grayLighter != nil else {
            grayLighter = self.hexToUIColor(hexString: "#E0E0E0")
            return grayLighter!
        }
        
        return grayLighter!
        
    }
    
    private var grayLightest: UIColor!
    public func getGrayLightest() -> UIColor {
        
        guard grayLightest != nil else {
            grayLightest = self.hexToUIColor(hexString: "#EFEFEF")
            return grayLightest!
        }
        
        return grayLightest!
        
    }
    
}
