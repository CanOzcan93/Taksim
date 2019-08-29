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
        
        CoreMapView.provideAPIKey("AIzaSyB6FQlF3Bn6k4WuoDQyjrCS7KJB1QYv0dg", "AIzaSyB6FQlF3Bn6k4WuoDQyjrCS7KJB1QYv0dg")
        
        return Authentication.Module.getInstance().factory!.sheetFactory!.getSplashSheet()
        
    }
    
}
