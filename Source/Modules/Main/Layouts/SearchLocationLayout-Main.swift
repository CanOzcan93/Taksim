//
//  SearchLocationLayout-Main.swift
//  Taksim
//
//  Created by Can Özcan on 8.08.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class SearchLocationLayout: TSLayout {
        
        public var addressInput: AddressInput!
        private var v_bgHeader: TSView!
        private var tv_header: TSTextView!
        public var lv: SearchLocationList!
        
        /*
         -
         -
         // MARK: Construction
         -
         -
         */
        
        public override func onConstruct() {
            
            super.onConstruct()
            self.addressInput = AddressInput(layout: self)
            constructHeaderBackgroundView()
            constructHeaderTextView()
            constructListView()
            
            
        }
        
        private func constructHeaderBackgroundView() {
            
            self.v_bgHeader = TSView()
            self.v_bgHeader.backgroundColor = self.colorProvider.getGrayLighter()
            self.addSubview(self.v_bgHeader)
        }
        
        private func constructHeaderTextView() {
            
            self.tv_header = TSTextView()
            self.tv_header.font = fontProvider.getSemiboldMedium()
            self.tv_header.text = "Adreslerim"
            self.tv_header.textAlignment = .left
            self.tv_header.textColor = colorProvider.getPureGray()
            self.addSubview(self.tv_header)
        }
        
        private func constructListView() {
            
//            self.lv = SearchLocationList(items: [
//                SearchLocationListItem(status: .Home, address: "cdacdas", coordinate: CoreCoordinate(latitude: 25.54, longitude: 25.54), addressID: 3),
//                SearchLocationListItem(status: .Work, address: nil, coordinate: nil, addressID: nil),
//                SearchLocationListItem(status: .Favorites, address: nil,coordinate: nil, addressID: nil)])
            self.lv = SearchLocationList(items: [])
            self.addSubview(self.lv)
        }
        
        /*
         -
         -
         // MARK: Constraining
         -
         -
         */
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            constrainHeaderBackgroundView(set: &set)
            constrainHeaderTextView(set: &set)
            constrainHeaderListView(set: &set)
            
        }
        
        private func constrainHeaderBackgroundView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_bgHeader, attribute: .top, relatedBy: .equal, toItem: addressInput.v_background, attribute: .bottom, multiplier: 1, constant: 0))
//            set.append(NSLayoutConstraint(item: v_bgHeader, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 90))
            set.append(NSLayoutConstraint(item: v_bgHeader, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_bgHeader, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_bgHeader, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 35))
            
        }
        
        private func constrainHeaderTextView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: tv_header, attribute: .centerY, relatedBy: .equal, toItem: v_bgHeader, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_header, attribute: .left, relatedBy: .equal, toItem: v_bgHeader, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: tv_header, attribute: .width, relatedBy: .equal, toItem: v_bgHeader, attribute: .width, multiplier: 1, constant: 40))
            set.append(NSLayoutConstraint(item: tv_header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 19))
        }
        
        private func constrainHeaderListView(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: lv, attribute: .top, relatedBy: .equal, toItem: v_bgHeader, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: lv, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        }
        
    }
    
}
