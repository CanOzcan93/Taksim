//
//  LoginLayout.swift
//  Authentication
//
//  Created by Can Özcan on 12.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import UIKit

extension Authentication {

    public class LoginLayout: FunnelLayout {
        
        // Fields
        
        public var ti_phone: TextInput!
        public var btn_next: Button!
        
        
        // Implementation
        
        public override func onHeading() -> String {
            return lexiconProvider.get("login")
        }
        
        public override func onInfo() -> String {
            return lexiconProvider.get("login_phone")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            constructPhone()
            constructNext()
            
            self.addSubview(ti_phone)
            self.addSubview(btn_next)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            constrainPhone(set: &set)
            constrainNext(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructPhone() {
            
            ti_phone = TextInput()
            ti_phone.setPlaceholder(text: "Telefon Numarası:")
            
        }
        
        private func constructNext() {
            
            btn_next = Button()
            btn_next.setTitle(lexiconProvider.get("next"), for: .normal)
            
        }
        
        private func constrainPhone(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_phone, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_phone, attribute: .top, relatedBy: .equal, toItem: tv_info, attribute: .bottom, multiplier: 1, constant: 32))
            set.append(NSLayoutConstraint(item: ti_phone, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -50))
            
        }
        
        private func constrainNext(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_next, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: -5))
            set.append(NSLayoutConstraint(item: btn_next, attribute: .top, relatedBy: .equal, toItem: ti_phone, attribute: .bottom, multiplier: 1, constant: 72))
            set.append(NSLayoutConstraint(item: btn_next, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.45, constant: 0))
            
        }
        
    }

}
