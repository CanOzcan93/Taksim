//
//  TSListView.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 12.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

open class TSListView<ItemType: TSListItemView>: CoreListView<ItemType> {
    
    
    // Sharepoint Injection
    
    private var sharepoint: TSSharepoint!
    
    private var agency: TSAgency!
    
    private var provider: TSProvider!
    
    private var animationProvider: TSAnimationProvider!
    private var colorProvider: TSColorProvider!
    private var fontProvider: TSFontProvider!
    private var imageProvider: TSImageProvider!
    private var lexiconProvider: TSLexiconProvider!
    
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
