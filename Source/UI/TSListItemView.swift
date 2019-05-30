//
//  TSListItemView.swift
//  Taksim
//
//  Created by Can Özcan on 12.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

open class TSListItemView: CoreListItemView {
    
    
    // Sharepoint Injection
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    
    private var provider: TSProvider!
    
    public var animationProvider: TSAnimationProvider!
    public var colorProvider: TSColorProvider!
    public var fontProvider: TSFontProvider!
    public var imageProvider: TSImageProvider!
    public var lexiconProvider: TSLexiconProvider!
    
    open override func onInjection() {
        
        super.onInjection()
        
        sharepoint = TSSharepoint.getInstance()
        
        agency = sharepoint.agency
        
        provider = agency.provider
        
        animationProvider = provider.animationProvider
        colorProvider = provider.colorProvider
        fontProvider = provider.fontProvider
        imageProvider = provider.imageProvider
        lexiconProvider = provider.lexiconProvider
        
    }
    
}
