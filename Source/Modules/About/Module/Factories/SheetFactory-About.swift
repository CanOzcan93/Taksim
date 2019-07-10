//
//  SheetFactory-About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension About {
    
    public class SheetFactory: CoreSheetFactory {
        
        private var faq: FaqSheet?
        public func getFaqSheet() -> FaqSheet {
            
            guard faq != nil else {
                faq = FaqSheet()
                return faq!
            }
            
            return faq!
            
        }
        
        private var help: HelpSheet?
        public func getHelpSheet() -> HelpSheet {
            
            guard help != nil else {
                help = HelpSheet()
                return help!
            }
            
            return help!
            
        }
        
        private var termOfUse: TermOfUseSheet?
        public func getTermOfUseSheet() -> TermOfUseSheet {
            
            guard termOfUse != nil else {
                termOfUse = TermOfUseSheet()
                return termOfUse!
            }
            
            return termOfUse!
            
        }
        
        private var aboutUs: AboutUsSheet?
        public func getAboutUsSheet() -> AboutUsSheet {
            
            guard aboutUs != nil else {
                aboutUs = AboutUsSheet()
                return aboutUs!
            }
            
            return aboutUs!
            
        }
        
        private var privacyPolicy: PrivacyPolicySheet?
        public func getPrivacyPolicySheet() -> PrivacyPolicySheet {
            
            guard privacyPolicy != nil else {
                privacyPolicy = PrivacyPolicySheet()
                return privacyPolicy!
            }
            
            return privacyPolicy!
            
        }
        
    }
    
}
