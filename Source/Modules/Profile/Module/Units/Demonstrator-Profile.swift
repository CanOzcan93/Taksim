//
//  Demonstrator-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
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
        
        public func toMainSheet() {
            
            sheet = sheetFactory.getMainSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toPhotoShootSheet() {
            sheet = sheetFactory.getPhotoShootSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func goBack() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
        }
        
    }
    
}
