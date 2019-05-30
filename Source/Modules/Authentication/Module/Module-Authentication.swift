//
//  Module.swift
//  TS
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Authentication {
    
    public class Module: CoreModule<Factory, PageFactory, SheetFactory, TransitionFactory, Navigator, Demonstrator> {
        
        private static var instance: Module?
        public static func getInstance() -> Module {
            
            guard instance != nil else {
                
                instance = Module()
                
                instance!.factory = Factory()
                instance!.factory!.pageFactory = PageFactory()
                instance!.factory!.sheetFactory = SheetFactory()
                instance!.factory!.transitionFactory = TransitionFactory()
                
                instance!.navigator = Navigator()
                instance!.demonstrator = Demonstrator()
                
                return instance!
                
            }
            
            return instance!
            
        }
        
        public static func resetInstance() {
            
            instance = nil
            
        }
        
    }
    
}
