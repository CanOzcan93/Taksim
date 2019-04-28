//
//  SignUpFormLayout.swift
//  Taksim
//
//  Created by E.E.E. on 1.02.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Authentication {
    
    public class SignUpFormLayout: FunnelLayout {

        // Fields
        
        public var ti_name: TextInput!
        public var ti_surname: TextInput!
        public var ti_email: TextInput!
        
        public var btn_next: Button!
        
        
        // Implementation
        
        public override func onHeading() -> String {
            return lexiconProvider.get("signup")
        }
        
        public override func onInfo() -> String {
            return lexiconProvider.get("signup_account")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            constructNameTextInput()
            constructSurnameTextInput()
            constructEmailTextInput()
            
            constructNext()
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            constrainName(set: &set)
            constrainSurname(set: &set)
            constrainEmail(set: &set)
            
            constrainNext(set: &set)
            
        }
        
        private func constructNameTextInput() {
            
            ti_name = TextInput()
            ti_name.setPlaceholder(text: "Adınız:")
            
            self.addSubview(ti_name)
            
        }
        
        private func constructSurnameTextInput() {
            
            ti_surname = TextInput()
            ti_surname.setPlaceholder(text: "Soyadınız:")
            
            self.addSubview(ti_surname)
            
        }
        
        private func constructEmailTextInput() {
            
            ti_email = TextInput()
            ti_email.setPlaceholder(text: "E-Posta:")
            ti_email.keyboardType = .emailAddress
            
            self.addSubview(ti_email)
            
        }
        
        private func constructNext() {
            
            btn_next = Button()
            btn_next.setTitle(lexiconProvider.get("next"), for: .normal)
            
            self.addSubview(btn_next)
            
        }
        
        private func constrainName(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_name, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_name, attribute: .top, relatedBy: .equal, toItem: tv_info, attribute: .bottom, multiplier: 1, constant: 32))
            set.append(NSLayoutConstraint(item: ti_name, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -50))
            
        }
        
        private func constrainSurname(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_surname, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_surname, attribute: .top, relatedBy: .equal, toItem: ti_name, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: ti_surname, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -50))
            
        }
        
        private func constrainEmail(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_email, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_email, attribute: .top, relatedBy: .equal, toItem: ti_surname, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: ti_email, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -50))
            
        }
        
        private func constrainNext(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_next, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: -5))
            set.append(NSLayoutConstraint(item: btn_next, attribute: .top, relatedBy: .equal, toItem: ti_email, attribute: .bottom, multiplier: 1, constant: 72))
            set.append(NSLayoutConstraint(item: btn_next, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.45, constant: 0))
            
        }
        
    }

}
