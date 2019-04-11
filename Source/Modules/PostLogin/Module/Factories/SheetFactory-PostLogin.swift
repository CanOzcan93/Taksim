//
//  SheetFactory-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class SheetFactory: CoreSheetFactory {
        
        private var promotion: PromotionSheet?
        public func getPromotionSheet() -> PromotionSheet {
            
            guard promotion != nil else {
                promotion = PromotionSheet()
                return promotion!
            }
            
            return promotion!
            
        }
        
    }
    
}
