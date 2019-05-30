//
//  Demonstrator.swift
//  TS
//
//  Created by Can Özcan on 20.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Authentication {
    
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
        
        public func toLoginSheet() {
            
            sheet = sheetFactory.getLoginSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toSignUpSheet() {
            
            sheet = sheetFactory.getSignUpSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toLoginVerificationSheet() {
            
            sheet = sheetFactory.getLoginVerificationSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toSignUpVerificationSheet() {
            
            sheet = sheetFactory.getSignUpVerificationSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toSignUpFormSheet() {
            
            sheet = sheetFactory.getSignUpFormSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toOnboardingSheet() {
            
            sheet = sheetFactory.getOnBoardingSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toMainModule() {
            
            let mainModule = Main.Module.getInstance()
            let mainFactory = mainModule.factory!
            let mainSheetFactory = mainFactory.sheetFactory!
            
            sheet = mainSheetFactory.getMainSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func goBack() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
        }
        
    }
    
}
