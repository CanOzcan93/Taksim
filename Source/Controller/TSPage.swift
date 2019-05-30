//
//  TSPage.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

open class TSPage<LayoutType: TSLayout>: CorePage<LayoutType> {
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    private var repository: TSRepository!
    
    private var manager: TSManager!
    private var provider: TSProvider!
    
    open var apiManager: TSApiManager!
    open var eventManager: TSEventManager!
    open var locationManager: TSLocationManager!
    open var networkManager: TSNetworkManager!
    open var mediaManager: TSMediaManager!
    
    open var animationProvider: TSAnimationProvider!
    open var fontProvider: TSFontProvider!
    open var colorProvider: TSColorProvider!
    open var imageProvider: TSImageProvider!
    open var lexiconProvider: TSLexiconProvider!
    
    open var dataStorage: TSDataStorage!
    open var exchangeFlow: TSExchangeFlow!
    open var persistentStorage: TSPersistentStorage!
    open var stateMachine: TSStateMachine!
    
    open override func onInjection() {
        
        sharepoint = TSSharepoint.getInstance()
        
        agency = sharepoint.agency
        repository = sharepoint.repository
        
        manager = agency.manager
        provider = agency.provider
        
        apiManager = manager.apiManager
        eventManager = manager.eventManager
        locationManager = manager.locationManager
        networkManager = manager.networkManager
        mediaManager = manager.mediaManager
        
        animationProvider = provider.animationProvider
        colorProvider = provider.colorProvider
        fontProvider = provider.fontProvider
        imageProvider = provider.imageProvider
        lexiconProvider = provider.lexiconProvider
        
        dataStorage = repository.dataStorage
        exchangeFlow = repository.exchangeFlow
        persistentStorage = repository.persistentStorage
        stateMachine = repository.stateMachine
        
    }
    
}
