//
//  FaqLayout-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension About {
    
    public class FaqLayout: PostLogin.WavyLayout {
        
        private var lv: FaqList!
        
        public override func onHeading() -> String {
            return lexiconProvider.get("faq")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.lv = FaqList(layout: self)
            
        }
        
    }
    
}
