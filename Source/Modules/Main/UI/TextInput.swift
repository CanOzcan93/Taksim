//
//  TextInput.swift
//  Taksim
//
//  Created by Can Özcan on 25.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import UIKit

extension Main {
    
    public class TextInput: TSTextInput {
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.font = fontProvider.getRegularSmall()
            
        }
        
    }
    
}
