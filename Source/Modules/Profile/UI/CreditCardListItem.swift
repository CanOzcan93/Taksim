//
//  CreditCardListItem.swift
//  Taksim
//
//  Created by Can Özcan on 14.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit
import Core

extension Profile {
    
    public class CreditCardListItem: TSListItemView {
        
        
        private var iv_card: TSImageView!
        private var tv_card: TSTextView!
        
        private var isInitialized: Bool = false
        
        public override func onInit() {
            
            self.item = TSView()
            self.item.isOpaque = false
            self.item.backgroundColor = .clear
            self.isUserInteractionEnabled = false
            contentView.addSubview(self.item)
            
        }
        
        public override func onConstruct(wrapper: UIView, item: CoreView) {
            super.onConstruct(wrapper: wrapper, item: item)
            
            constructImageCard(item: item)
            constructCardTextView(item: item)
        }

//        public func changeLabels(name: String?, no: String?, date: String?, price: Double?) {
//            if name != nil {
//                tv_name.text = "Isim: \(name!)"
//            }
//            if no != nil {
//                tv_no.text = "Plaka: \(no!)"
//            }
//            if date != nil {
//                tv_date.text = "Tarih: \(date!)"
//            }
//            if price != nil {
//                tv_km_price.text = "\(price!) TL"
//            }
//        }
//

        private func constructImageCard(item: CoreView) {

            self.iv_card = TSImageView()
            self.iv_card.image = imageProvider.getLogoBonus()
            self.iv_card.contentMode = .scaleAspectFit

            item.addSubview(self.iv_card)

        }

        private func constructCardTextView(item: CoreView) {

            self.tv_card = TSTextView()
            self.tv_card.text = "Kredi Karti: \n **** **** **** 3585 10/23"
            self.tv_card.numberOfLines = 2
            self.tv_card.font = fontProvider.getRegularSmall()
            self.tv_card.textColor = colorProvider.getDarkGray()

            item.addSubview(self.tv_card)

        }

        public override func onConstrain(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            super.onConstrain(set: &set, wrapper: wrapper, item: item)

            set.append(NSLayoutConstraint(item: wrapper, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))

            set.append(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: wrapper, attribute: .width, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: 0))
            
            constrainImageCard(set: &set, wrapper: wrapper, item: item)
            constrainCardTextView(set: &set, wrapper: wrapper, item: item)

        }

        private func constrainImageCard(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: iv_card, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: iv_card, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_card, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: iv_card, attribute: .width, relatedBy: .equal, toItem: iv_card, attribute: .height, multiplier: 1.5, constant: 0))

        }

        private func constrainCardTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: tv_card, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_card, attribute: .left, relatedBy: .equal, toItem: iv_card, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_card, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: tv_card, attribute: .height, relatedBy: .equal, toItem: iv_card, attribute: .height, multiplier: 1, constant: 0))

        }

        
    }
    
}
