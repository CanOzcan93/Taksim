//
//  TSSharepoint.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core


public class TSSharepoint: CoreSharepoint<TSAgency, TSManager, TSApiManager, TSEventManager, TSLocationManager, TSNetworkManager, TSMediaManager, TSProvider, TSAnimationProvider, TSColorProvider, TSFontProvider, TSImageProvider, TSLexiconProvider, TSLexicon, TSLanguage, TSRepository, TSDataStorage, TSExchangeFlow, TSPersistentStorage, TSStateMachine> {
    
    private static var instance: TSSharepoint?
    public static func getInstance() -> TSSharepoint {
        
        guard instance != nil else {
            
            instance = TSSharepoint()
            
            instance!.agency = TSAgency()
            instance!.agency!.manager = TSManager()
            instance!.agency!.manager!.apiManager = TSApiManager()
            instance!.agency!.manager!.eventManager = TSEventManager()
            instance!.agency!.manager!.locationManager = TSLocationManager()
            instance!.agency!.manager!.networkManager = TSNetworkManager()
            instance!.agency!.manager!.mediaManager = TSMediaManager()
            instance!.agency!.provider = TSProvider()
            instance!.agency!.provider!.animationProvider = TSAnimationProvider()
            instance!.agency!.provider!.colorProvider = TSColorProvider()
            instance!.agency!.provider!.fontProvider = TSFontProvider()
            instance!.agency!.provider!.imageProvider = TSImageProvider()
            instance!.agency!.provider!.lexiconProvider = TSLexiconProvider()
            
            instance!.repository = TSRepository()
            instance!.repository!.dataStorage = TSDataStorage()
            instance!.repository!.exchangeFlow = TSExchangeFlow()
            instance!.repository!.persistentStorage = TSPersistentStorage()
            instance!.repository!.stateMachine = TSStateMachine()
            
            instance!.agency!.manager!.apiManager!.injectDependencies() 
            
            return instance!
            
        }
        
        return instance!
        
    }
    
    public static func resetSharepoint() {
        instance = nil
    }
    
}
