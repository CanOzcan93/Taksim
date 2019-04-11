//
//  TSCompundView.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 5.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

open class TSCompoundView: CoreCompoundView {
    
    
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
        
        super.onInjection()
        
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
