//
//  OrderListItem.swift
//  Taksim
//
//  Created by Can Özcan on 18.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit
import Core

extension Profile {
    
    public class OrderListItem: TSListItemView {
        
        
        private var ti_pickUp: Main.TextInput!
        private var v_line: TSView!
        private var ti_destination: Main.TextInput!
        private var iv_from: TSImageView!
        private var iv_dots: TSImageView!
        private var iv_to: TSImageView!
        
        public override func onConstruct(wrapper: UIView, item: CoreView) {
            
            super.onConstruct(wrapper: wrapper, item: item)
            
            constructFromTextInput(item: item)
            constructLineView(item: item)
            constructToTextInput(item: item)
            constructFromIcon(item: item)
            constructDotsIcon(item: item)
            constructToIcon(item: item)

        }

        private func constructFromTextInput(item: CoreView) {

            self.ti_pickUp = Main.TextInput()
            self.ti_pickUp.tag = 0
            self.ti_pickUp.setPlaceholder(text: lexiconProvider.get("current_location"))
            self.ti_pickUp.onTap {
                self.ti_pickUp.endEditing(true)
            }
            item.addSubview(self.ti_pickUp)

        }

        private func constructLineView(item: CoreView) {

            self.v_line = TSView()
            self.v_line.backgroundColor = colorProvider.getGrayLight()

            item.addSubview(self.v_line)

        }

        private func constructToTextInput(item: CoreView) {

            self.ti_destination = Main.TextInput()
            self.ti_destination.tag = 1
            self.ti_destination.setPlaceholder(text: lexiconProvider.get("destination_location"))
            self.ti_destination.onTap {
                self.ti_destination.endEditing(true)
            }
            item.addSubview(self.ti_destination)

        }


        private func constructFromIcon(item: CoreView) {

            self.iv_from = TSImageView()
            self.iv_from.image = imageProvider.getBullsEye()

            item.addSubview(self.iv_from)

        }

        private func constructDotsIcon(item: CoreView) {

            self.iv_dots = TSImageView()
            self.iv_dots.image = imageProvider.getVerticalDots()

            item.addSubview(self.iv_from)

        }

        private func constructToIcon(item: CoreView) {

            self.iv_to = TSImageView()
            self.iv_to.image = imageProvider.getLocation()

            item.addSubview(self.iv_from)

        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            super.onConstrain(set: &set, wrapper: wrapper, item: item)
            
            set.append(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: wrapper, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .top, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: -10))
            
            
            constrainFromTextInput(set: &set, wrapper: wrapper, item: item)
            constrainLineView(set: &set, wrapper: wrapper, item: item)
            constrainToTextInput(set: &set, wrapper: wrapper, item: item)
            constrainFromIcon(set: &set, wrapper: wrapper, item: item)
            constrainDotsIcon(set: &set, wrapper: wrapper, item: item)
            constrainToIcon(set: &set, wrapper: wrapper, item: item)
            
        }
        
        private func constrainFromTextInput(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: ti_pickUp, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: ti_pickUp, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_pickUp, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 40))

        }

        private func constrainLineView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: v_line, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line, attribute: .width, relatedBy: .equal, toItem: item, attribute: .width, multiplier: 1, constant: -35))
            set.append(NSLayoutConstraint(item: v_line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))

        }

        private func constrainToTextInput(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: ti_destination, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: .bottom, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: ti_destination, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti_destination, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 40))

        }

        private func constrainFromIcon(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: iv_from, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: iv_from, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: iv_from, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 12))
            set.append(NSLayoutConstraint(item: iv_from, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 12))

        }

        private func constrainDotsIcon(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: iv_dots, attribute: .centerX, relatedBy: .equal, toItem: iv_from, attribute: .centerX, multiplier: 1, constant: 17.5))
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 2))
            set.append(NSLayoutConstraint(item: iv_dots, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 14))

        }

        private func constrainToIcon(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: iv_to, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 12.5))
            set.append(NSLayoutConstraint(item: iv_to, attribute: .top, relatedBy: .equal, toItem: iv_dots, attribute: .bottom, multiplier: 1, constant: 2))
            set.append(NSLayoutConstraint(item: iv_to, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 12))
            set.append(NSLayoutConstraint(item: iv_to, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 16.5))

        }
        
    }
    
}
