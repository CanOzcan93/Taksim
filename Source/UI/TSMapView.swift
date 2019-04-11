//
//  TSMapView.swift
//  Taksim
//
//  Created by Can Özcan on 2.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import GooglePlaces
import GoogleMaps

open class TSMapView: CoreMapView {
    
    
    // Sharepoint
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    
    private var manager: TSManager!
    
    private var apiManager: TSApiManager!
    
    private var provider: TSProvider!
    
    public var animationProvider: TSAnimationProvider!
    public var fontProvider: TSFontProvider!
    public var colorProvider: TSColorProvider!
    public var imageProvider: TSImageProvider!
    public var lexiconProvider: TSLexiconProvider!
    
    open override func onInjection() {
        
        super.onInjection()
        
        sharepoint = TSSharepoint.getInstance()
        
        agency = sharepoint.agency
        
        manager = agency.manager
        
        apiManager = manager.apiManager
        
        provider = agency.provider
        
        animationProvider = provider.animationProvider
        fontProvider = provider.fontProvider
        colorProvider = provider.colorProvider
        imageProvider = provider.imageProvider
        lexiconProvider = provider.lexiconProvider
        
    }
    
}
