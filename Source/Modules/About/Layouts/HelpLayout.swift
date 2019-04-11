//
//  HelpLayout-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension About {
    
    public class HelpLayout: PostLogin.WavyLayout {
        
        private var lv: HelpList!
        
        public override func onHeading() -> String {
            return lexiconProvider.get("help")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.lv = HelpList(layout: self)
            
        }
        
    }
    
}
