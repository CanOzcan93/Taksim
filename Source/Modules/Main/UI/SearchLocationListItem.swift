//
//  SearchLocationListItem.swift
//  Taksim
//
//  Created by Can Özcan on 14.08.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit
import Core

extension Main {
    
    public enum SearchItemType {
        case Home
        case Work
        case Favorites
    }
    
    public class SearchLocationListItem: TSListItemView {
        
        public init(status: SearchItemType, address: String?, coordinate: CoreCoordinate?, addressID: UInt?, onClickItem: Action!, onClickButton: Action!) {
            self.type = status
            if address != nil && coordinate != nil {
                self.address = address
                self.coordinate = coordinate
                self.addressID = addressID
                self.isActive = true
            }
            else {
                self.isActive = false
            }
            self.onClickItem = onClickItem
            self.onClickButton = onClickButton
            super.init()
            self.isUserInteractionEnabled = true
        }
        
        required init?(coder decoder: NSCoder) {
            super.init(coder: decoder)
        }
        
        open override class var dequeueItemName: String {
            return "SearchLocationListItem"
        }
        
        private var iv_logo: TSImageView!
        private var tv_index: TSTextView!
        public var btn_plus: TSImageView!
        private var type: SearchItemType!
        public var isActive: Bool!
        public var address: String?
        public var coordinate: CoreCoordinate?
        public var addressID: UInt?
        
        // MARK: Actions
        public var onClickItem: Action!
        public var onClickButton: Action!
        
        public override func onInit() {
            self.item = TSView()
            self.item.isOpaque = false
            self.isUserInteractionEnabled = false
            self.item.onTap {
                self.onClickItem?()
            }
            
            contentView.addSubview(self.item)
            
        }
        
        public override func onConstruct(wrapper: UIView, item: CoreView) {
            
            super.onConstruct(wrapper: wrapper, item: item)
            
            constructImageLogo(item: item)
            constructIndexTextView(item: item)
            constructPlusButton(item: item)
            
        }
        
        private func constructImageLogo(item: CoreView) {
            
            self.iv_logo = TSImageView()
            self.iv_logo.backgroundColor = .clear
            let typeDefined = type!
            if typeDefined == .Home {
                self.iv_logo.image = imageProvider.getHome().withRenderingMode(.alwaysTemplate)
            }
            else if typeDefined == .Work {
                self.iv_logo.image = imageProvider.getSuitcase().withRenderingMode(.alwaysTemplate)

            }
            else {
                self.iv_logo.image = imageProvider.getOutlinedStar().withRenderingMode(.alwaysTemplate)
            }
            self.iv_logo.tintColor = colorProvider.getDarkGray()
            
            item.addSubview(self.iv_logo)
            
        }
        
        private func constructIndexTextView(item: CoreView) {
            
            self.tv_index = TSTextView()
            let typeDefined = type!
            if isActive {
                self.tv_index.text = self.address
            }
            else {
                if typeDefined == .Home {
                    self.tv_index.text = "Ev adresi ekle"
                }
                else if typeDefined == .Work {
                    self.tv_index.text = "İş adresi ekle"
                }
                else {
                    self.tv_index.text = "Favori adres ekle"
                }
            }
            self.tv_index.font = fontProvider.getLightMedium()
            self.tv_index.textColor = colorProvider.getDarkGray()
            
            item.addSubview(self.tv_index)
            
        }
        
        private func constructPlusButton(item: CoreView) {
            
            self.btn_plus = TSImageView()
            self.btn_plus.backgroundColor = .clear
            if !isActive {
                self.btn_plus.image = imageProvider.getPlusSimple()
            }
            else {
                self.btn_plus.image = imageProvider.getQuitSimple()
            }
            
            self.btn_plus.onTap {
                self.onClickButton?()
            }
            item.addSubview(self.btn_plus)
            
        }
        
        
        
        
        public override func onConstrain(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            super.onConstrain(set: &set, wrapper: wrapper, item: item)
            
            set.append(NSLayoutConstraint(item: wrapper, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40))
            
            set.append(NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: wrapper, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: wrapper, attribute: .left, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: 0))
            
            constrainImageLogo(set: &set, wrapper: wrapper, item: item)
            constrainIndexTextView(set: &set, wrapper: wrapper, item: item)
            constrainPlusButton(set: &set, wrapper: wrapper, item: item)
            
        }
        
        private func constrainImageLogo(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 18))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 18))
            
        }
        
        private func constrainIndexTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            set.append(NSLayoutConstraint(item: tv_index, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_index, attribute: .left, relatedBy: .equal, toItem: iv_logo, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_index, attribute: .right, relatedBy: .equal, toItem: btn_plus, attribute: .left, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: tv_index, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22))
            
            
        }
        
        private func constrainPlusButton(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            set.append(NSLayoutConstraint(item: btn_plus, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn_plus, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: btn_plus, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 18))
            set.append(NSLayoutConstraint(item: btn_plus, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 18))
            
        }
        
        public func resetItem() {
            
            self.isActive = false
            self.address = nil
            self.coordinate = nil
            self.addressID = nil
            
            let typeDefined = type!
            if typeDefined == .Home {
                self.tv_index.text = "Ev adresi ekle"
            }
            else if typeDefined == .Work {
                self.tv_index.text = "İş adresi ekle"
            }
            else {
                self.tv_index.text = "Favori adres ekle"
            }
            self.btn_plus.image = imageProvider.getPlusSimple()
            
        }
        
        public func resetFunctions(onClickItem: Action!, onClickButton: Action!) {
            self.onClickItem = onClickItem
            self.onClickButton = onClickButton
            self.btn_plus.onTap(delegate: self.onClickButton)
            self.item.onTap(delegate: self.onClickItem)
        }
        
        
        
        
    }
    
}

