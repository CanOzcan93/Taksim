//
//  PrivacyPolicyLayout-About.swift
//  Taksim
//
//  Created by Can Özcan on 10.07.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation

extension About {
    
    public class PrivacyPolicyLayout: HelpWebViewLayout {
        
        public override func getURL() -> String? {
            return "http://www.taksimizmir.com/app_content/privacy-policy.html"
        }
        
    }
    
}
