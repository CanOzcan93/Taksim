//
//  TSTransitiveView.swift
//  Taksim
//
//  Created by Can Özcan on 5.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

open class TSTransitiveView<TransitiveType: Any>: CoreTransitiveView<TransitiveType> {
    
    
    // Sharepoint
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    
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
        
        provider = agency.provider
        
        animationProvider = provider.animationProvider
        fontProvider = provider.fontProvider
        colorProvider = provider.colorProvider
        imageProvider = provider.imageProvider
        lexiconProvider = provider.lexiconProvider
        
    }
    
}
