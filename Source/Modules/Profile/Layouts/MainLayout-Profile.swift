//
//  MainLayout-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class MainLayout: PostLogin.WavyLayout {

        // Fields
        
        public var iv_avatar: TSImageView!
        public var iv_plus: TSImageView!
        
        public var ti_name: PostLogin.TextInput!
        public var ti_surname: PostLogin.TextInput!
        public var ti_phone: PostLogin.TextInput!
        public var ti_email: PostLogin.TextInput!
        
        public var btn_save: PostLogin.Button!

        
        // Implementation
        
        public override func onHeading() -> String {
            return lexiconProvider.get("profile")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            constructAvatarImage()
            constructPlusImage()
            
            constructNameTextInput()
            constructSurnameTextInput()
            constructPhoneTextInput()
            constructEmailTextInput()
            
            constructSaveButton()

        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            constrainAvatarImage(set: &set)
            constrainPlusImage(set: &set)

            constrainNameTextInput(set: &set)
            constrainSurnameTextInput(set: &set)
            constrainPhoneTextInput(set: &set)
            constrainEmailTextInput(set: &set)

            constrainSaveButton(set: &set)
            
        }
        
        
        // Internal Methods
        
        private func constructAvatarImage() {
            
            self.iv_avatar = TSImageView()
            self.iv_avatar.image = imageProvider.getAvatar()
            
            self.addSubview(self.iv_avatar)
            
        }
        
        private func constructPlusImage() {
            
            self.iv_plus = TSImageView()
            self.iv_plus.image = imageProvider.getPlus()
            
            self.addSubview(self.iv_plus)
            
        }
        
        private func constructNameTextInput() {
            
            self.ti_name = PostLogin.TextInput()
            self.ti_name.returnKeyType = .next
            self.ti_name.setPlaceholder(text: lexiconProvider.get("name"))
            self.ti_name.onPressReturnInKeyboard = {
                self.endEditing(true)
                self.ti_surname.becomeFirstResponder()
            }
            
            self.addSubview(self.ti_name)
            
        }
        
        private func constructSurnameTextInput() {
            
            self.ti_surname = PostLogin.TextInput()
            self.ti_surname.returnKeyType = .next
            self.ti_surname.setPlaceholder(text: lexiconProvider.get("last_name"))
            self.ti_surname.onPressReturnInKeyboard = {
                self.endEditing(true)
                self.ti_phone.becomeFirstResponder()
            }
            
            self.addSubview(self.ti_surname)
            
        }
        
        private func constructPhoneTextInput() {
            
            self.ti_phone = PostLogin.TextInput()
            self.ti_phone.returnKeyType = .next
            self.ti_phone.setPlaceholder(text: lexiconProvider.get("phone"))
            self.ti_phone.onPressReturnInKeyboard = {
                self.endEditing(true)
                self.ti_email.becomeFirstResponder()
            }
            
            self.addSubview(self.ti_phone)
            
        }
        
        private func constructEmailTextInput() {
            
            self.ti_email = PostLogin.TextInput()
            self.ti_email.keyboardType = .emailAddress
            self.ti_email.returnKeyType = .done
            self.ti_email.setPlaceholder(text: lexiconProvider.get("email"))
            self.ti_email.onPressReturnInKeyboard = {
                self.endEditing(true)
            }
            
            
            self.addSubview(self.ti_email)
            
        }
        
        private func constructSaveButton() {
            
            self.btn_save = PostLogin.Button()
            self.btn_save.setTitle(lexiconProvider.get("save"), for: .normal)
            
            self.addSubview(self.btn_save)
            
        }
        
        private func constrainAvatarImage(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100))
            set.append(NSLayoutConstraint(item: iv_avatar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100))
            
        }
        
        private func constrainPlusImage(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_plus, attribute: .centerX, relatedBy: .equal, toItem: iv_avatar, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_plus, attribute: .centerY, relatedBy: .equal, toItem: iv_avatar, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_plus, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 35))
            set.append(NSLayoutConstraint(item: iv_plus, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 35))
            
        }
        
        private func constrainNameTextInput(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_name, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_name, attribute: .top, relatedBy: .equal, toItem: iv_avatar, attribute: .bottom, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: ti_name, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -40))
            
        }
        
        private func constrainSurnameTextInput(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_surname, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_surname, attribute: .top, relatedBy: .equal, toItem: ti_name, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: ti_surname, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -40))
            
        }
        
        private func constrainPhoneTextInput(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_phone, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_phone, attribute: .top, relatedBy: .equal, toItem: ti_surname, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: ti_phone, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -40))
            
        }
        
        private func constrainEmailTextInput(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: ti_email, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_email, attribute: .top, relatedBy: .equal, toItem: ti_phone, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: ti_email, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -40))
            
        }
        
        private func constrainSaveButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_save, attribute: .top, relatedBy: .equal, toItem: ti_email, attribute: .top, multiplier: 1, constant: 75))
            set.append(NSLayoutConstraint(item: btn_save, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.5, constant: 0))
            
        }
        
    }
    
}
