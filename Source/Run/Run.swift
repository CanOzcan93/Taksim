//
//  Run.swift
//  Taksim
//
//  Created by Can Özcan on 12.03.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//
import Core
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class App: TSApplication {
    
    override func onRootViewController() -> UIViewController? {
        
        GMSPlacesClient.provideAPIKey("AIzaSyDndVi2_0-2HraeJItqdJtALmTI291j8_Y")
        GMSServices.provideAPIKey("AIzaSyDndVi2_0-2HraeJItqdJtALmTI291j8_Y")
        
        return Authentication.Module.getInstance().factory!.sheetFactory!.getSplashSheet()
        
    }
    
}
