//
//  Demonstrator-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension About {
    
    public class Demonstrator: CoreDemonstrator {
        
        private var module: Module!
        
        private var factory: Factory!
        
        private var sheetFactory: SheetFactory!
        private var transitionFactory: TransitionFactory!
        
        public required init() {
            
            module = Module.getInstance()
            
            factory = module.factory
            
            sheetFactory = factory.sheetFactory
            transitionFactory = factory.transitionFactory
            
        }
        
        public func toTermOfUseSheet() {
            
            sheet = sheetFactory.getTermOfUseSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toAboutUsSheet() {
            
            sheet = sheetFactory.getAboutUsSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toPrivacyPolicySheet() {
            
            sheet = sheetFactory.getPrivacyPolicySheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func goBack() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
        }
        
    }
    
}
