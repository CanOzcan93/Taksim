//
//  CancelButton-PostLogin.swift
//  Taksim
//
//  Created by Can Özcan on 22.07.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class CancelButton: TSButton {
        
        public override func onConstruct() {
            super.onConstruct()
            self.backgroundColor = colorProvider.getGrayLight()
        }
        
        public override func draw(_ rect: CGRect) {
            super.draw(rect)
        }
        
    }
    
}
