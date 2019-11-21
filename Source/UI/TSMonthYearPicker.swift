//
//  TSMonthYearPicker.swift
//  Taksim
//
//  Created by Can Özcan on 21.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core


open class TSMonthYearPicker: CoreMonthYearPicker {
    
    
    // Sharepoint
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    
    private var provider: TSProvider!
    
    open var animationProvider: TSAnimationProvider!
    open var fontProvider: TSFontProvider!
    open var colorProvider: TSColorProvider!
    open var imageProvider: TSImageProvider!
    open var lexiconProvider: TSLexiconProvider!
    
    open override func onInjection() {
        
        sharepoint = TSSharepoint.getInstance()
        
        agency = sharepoint.agency
        
        provider = agency.provider
        
        animationProvider = provider.animationProvider
        fontProvider = provider.fontProvider
        colorProvider = provider.colorProvider
        imageProvider = provider.imageProvider
        lexiconProvider = provider.lexiconProvider
        
    }
    
}
