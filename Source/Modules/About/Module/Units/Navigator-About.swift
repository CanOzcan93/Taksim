//
//  Navigator-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension About {
    
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
