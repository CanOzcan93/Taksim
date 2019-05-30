//
//  TextView.swift
//  Taksim
//
//  Created by Can Özcan on 13.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit

extension PostLogin {
    
    public class TextView: TSTextView {
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.textColor = colorProvider.getDarkGray()
            self.font = fontProvider.getRegularMedium()
            self.textAlignment = .left
            
        }
        
    }
    
}
