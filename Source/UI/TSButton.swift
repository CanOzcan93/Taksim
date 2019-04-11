//
//  TSButton.swift
//  TS
//
//  Created by Erhan Emre Eroğlu on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

open class TSButton: CoreButton {
    
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
    
    
    // TS Adaptation
    
    open override func onConstruct() {
        
        super.onConstruct()
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = fontProvider.getSemiboldMedium()
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        
    }
    
    open override func onConstrain() {
        
        self.constrain(constraint: NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        
    }
    
}
