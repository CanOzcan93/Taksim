//
//  AddCardLayout-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 16.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class AddCardLayout: PostLogin.WavyLayout {
        
//        public var lv: CreditCardList!
        
        private var tv_header: TSTextView!
        public var gi_name: PostLogin.GeneralInput!
        public var gi_card: PostLogin.GeneralInput!
        public var gi_picker: PostLogin.GeneralYearPicker!
        public var gi_cvv: PostLogin.GeneralInput!
        public var btn_accept: PostLogin.Button!
        
        public override func onHeading() -> String {
            return "Kredi Kartlarım"
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            constructHeaderTextView()
            constructGeneralInputName()
            constructGeneralInputCard()
            constructAcceptButton()
            constructGeneralPicker()
            constructGeneralInputCVV()
            
        }
        
        private func constructHeaderTextView(){
            
            tv_header = TSTextView()
            tv_header.text = "Kart Ekle"
            tv_header.font = fontProvider.getSemiboldMid()
            tv_header.textColor = colorProvider.getDarkGray()
            self.addSubview(tv_header)
            
        }
        
        private func constructGeneralInputName() {
            
            gi_name = PostLogin.GeneralInput(layout: self)
            gi_name.addPlaceholder("Kart İsmi")
            
        }
        
        private func constructGeneralInputCard() {
            
            gi_card = PostLogin.GeneralInput(layout: self)
            gi_card.addPlaceholder("Kart Numarası")
            
        }
        
        private func constructGeneralPicker() {
            
            gi_picker = PostLogin.GeneralYearPicker(layout: self)
            
        }
        
        private func constructGeneralInputCVV() {
            
            gi_cvv = PostLogin.GeneralInput(layout: self)
            gi_cvv.addPlaceholder("CVV")
            
        }
        
        private func constructAcceptButton() {
            
            self.btn_accept = PostLogin.Button()
            self.btn_accept.setTitle("Kart Ekle", for: .normal)
            self.btn_accept.layer.cornerRadius = 20
            
            self.addSubview(self.btn_accept)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            constrainHeaderTextView(set: &set)
            constrainGeneralInputName(set: &set)
            constrainGeneralInputCard(set: &set)
            constrainGeneralPicker(set: &set)
            constrainGeneralInputCVV(set: &set)
            constrainAcceptButton(set: &set)
            
        }
        
        private func constrainHeaderTextView(set: inout [NSLayoutConstraint]){
            
            set.append(NSLayoutConstraint(item: tv_header, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 115))
            set.append(NSLayoutConstraint(item: tv_header, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: tv_header, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: tv_header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            
        }
        
        private func constrainGeneralInputName(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: gi_name.v_inputBackground, attribute: .top, relatedBy: .equal, toItem: tv_header, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: gi_name.v_inputBackground, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: gi_name.v_inputBackground, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            
        }
        
        private func constrainGeneralInputCard(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: gi_card.v_inputBackground, attribute: .top, relatedBy: .equal, toItem: gi_name.v_inputBackground, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: gi_card.v_inputBackground, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: gi_card.v_inputBackground, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            
        }
        
        private func constrainGeneralPicker(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: gi_picker.v_inputBackground, attribute: .top, relatedBy: .equal, toItem: gi_card.v_inputBackground, attribute: .bottom, multiplier: 1, constant: 10))
            
        }
        
        private func constrainGeneralInputCVV(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: gi_cvv.v_inputBackground, attribute: .top, relatedBy: .equal, toItem: gi_picker.v_inputBackground, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: gi_cvv.v_inputBackground, attribute: .left, relatedBy: .equal, toItem: gi_picker.v_inputBackground, attribute: .right, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: gi_cvv.v_inputBackground, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            
        }
        
        private func constrainAcceptButton(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: btn_accept, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn_accept, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -70))
            set.append(NSLayoutConstraint(item: btn_accept, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
            set.append(NSLayoutConstraint(item: btn_accept, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
//        public func controlTextView() -> Bool {
//
//
//
//
//        }
        
    }
    
}
