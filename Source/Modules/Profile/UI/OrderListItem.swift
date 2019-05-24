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
        
        
        private var iv_driver: TSImageView!
        
        private var tv_name: TSTextView!
        private var tv_no: TSTextView!
        private var tv_date: TSTextView!
        private var tv_km_price: TSTextView!
        
        private var iv_star: TSImageView!
        
        private var isInitialized: Bool = false
        
        
        public override func onInit() {
            self.item = TSView()
            self.item.isOpaque = false
            self.isUserInteractionEnabled = false
            
            self.item.onDraw = { rect in

                if !self.isInitialized {

                    let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height*0.2).cgPath
                    let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)), cornerRadius: 8).cgPath

                    let layer = CAShapeLayer()
                    layer.path = path
                    layer.fillColor = self.colorProvider.getWhiteFull().cgColor

                    layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                    layer.shadowPath = shadowPath
                    layer.shadowOffset = .zero
                    layer.shadowOpacity = 0.2
                    layer.shadowRadius = 8

                    self.item.layer.insertSublayer(layer, at: 0)

                    self.isInitialized = true
                }

            }
            
            contentView.addSubview(self.item)
            
        }
        
        public func changeLabels(name: String?, no: String?, date: String?, price: Double?) {
            if name != nil {
                tv_name.text = "Isim: \(name!)"
            }
            if no != nil {
                tv_no.text = "Plaka: \(no!)"
            }
            if date != nil {
                tv_date.text = "Tarih: \(date!)"
            }
            if price != nil {
                tv_km_price.text = "\(price!) TL"
            }
        }
        
        public override func onConstruct(wrapper: UIView, item: CoreView) {
            
            super.onConstruct(wrapper: wrapper, item: item)
            
            constructImageDriver(item: item)
            constructNameTextView(item: item)
            constructNoTextView(item: item)
            constructDateTextView(item: item)
            constructKmPriceTextView(item: item)

        }
        
        private func constructImageDriver(item: CoreView) {
            
            self.iv_driver = TSImageView()
            self.iv_driver.backgroundColor = colorProvider.getGrayLightest()
            self.iv_driver.image = imageProvider.getProfile()
            
            item.addSubview(self.iv_driver)
            
        }

        private func constructNameTextView(item: CoreView) {

            self.tv_name = TSTextView()
            self.tv_name.text = "Isim: "
            self.tv_name.font = fontProvider.getRegularSmall()
            self.tv_name.textColor = colorProvider.getDarkGray()
            
            item.addSubview(self.tv_name)

        }

        private func constructNoTextView(item: CoreView) {
            
            self.tv_no = TSTextView()
            self.tv_no.text = "Plaka: "
            self.tv_no.font = fontProvider.getRegularSmall()
            self.tv_no.textColor = colorProvider.getDarkGray()
            
            item.addSubview(self.tv_no)
            
        }

        private func constructDateTextView(item: CoreView) {
            
            self.tv_date = TSTextView()
            self.tv_date.text = "Tarih: "
            self.tv_date.font = fontProvider.getRegularSmall()
            self.tv_date.textColor = colorProvider.getDarkGray()
            
            item.addSubview(self.tv_date)
            
        }
        
        private func constructKmPriceTextView(item: CoreView) {
            
            self.tv_km_price = TSTextView()
            self.tv_km_price.text = "50 TL"
            self.tv_km_price.textAlignment = .right
            self.tv_km_price.font = fontProvider.getRegularSmall()
            self.tv_km_price.textColor = colorProvider.getDarkGray()
            
            item.addSubview(self.tv_km_price)
            
        }



        
        public override func onConstrain(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            super.onConstrain(set: &set, wrapper: wrapper, item: item)
            
            set.append(NSLayoutConstraint(item: wrapper, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100))
            
            set.append(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: wrapper, attribute: .width, multiplier: 1, constant: -10))
            set.append(NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .top, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: -10))
            
            constrainImageDriver(set: &set, wrapper: wrapper, item: item)
            constrainNoTextView(set: &set, wrapper: wrapper, item: item)
            constrainNameTextView(set: &set, wrapper: wrapper, item: item)
            constrainDateTextView(set: &set, wrapper: wrapper, item: item)
            constrainKmPriceTextView(set: &set, wrapper: wrapper, item: item)
            
        }
        
        private func constrainImageDriver(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            set.append(NSLayoutConstraint(item: iv_driver, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 7.5))
            set.append(NSLayoutConstraint(item: iv_driver, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: iv_driver, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: .bottom, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: iv_driver, attribute: .width, relatedBy: .equal, toItem: iv_driver, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainNoTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: tv_no, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 4))
            set.append(NSLayoutConstraint(item: tv_no, attribute: .left, relatedBy: .equal, toItem: iv_driver, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_no, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 150))
            set.append(NSLayoutConstraint(item: tv_no, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 0.2, constant: 0))

        }

        private func constrainNameTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: tv_name, attribute: .top, relatedBy: .equal, toItem: tv_no, attribute: .bottom, multiplier: 1, constant: 4))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .left, relatedBy: .equal, toItem: iv_driver, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 0.2, constant: 0))
            

        }

        private func constrainDateTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {

            set.append(NSLayoutConstraint(item: tv_date, attribute: .top, relatedBy: .equal, toItem: tv_name, attribute: .bottom, multiplier: 1, constant: 4))
            set.append(NSLayoutConstraint(item: tv_date, attribute: .left, relatedBy: .equal, toItem: iv_driver, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_date, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_date, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 0.2, constant: 0))

        }
        
        private func constrainKmPriceTextView(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            set.append(NSLayoutConstraint(item: tv_km_price, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 4))
            set.append(NSLayoutConstraint(item: tv_km_price, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: tv_km_price, attribute: .left, relatedBy: .equal, toItem: tv_no, attribute: .right, multiplier: 1, constant: 5))
            set.append(NSLayoutConstraint(item: tv_km_price, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: 0.2, constant: 0))
            
        }

        

        
    }
    
}
