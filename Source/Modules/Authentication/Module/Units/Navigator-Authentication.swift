//
//  Navigator.swift
//  TS
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Authentication {
    
    public class Navigator: CoreNavigator {
        
        private var module: Module!
        
        private var pageFactory: PageFactory!
        private var transitionFactory: TransitionFactory!
        
        private func backFromLeftToRight() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
        }
        
    }
    
}
