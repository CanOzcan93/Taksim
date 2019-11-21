//
//  OnboardingLayout-Authentication.swift
//  Taksim
//
//  Created by Can Özcan on 22.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation
import Core

extension Authentication {
    
    public class OnboardingLayout: TSLayout {
     
        private var v_bc: TSView!
        
        private var slider: TutorialSlider!
        private var pageControl: TutorialPageControl!
        
        private var iv_logo: TSImageView!
        
        
        public var btn: TSButton!
        
        public override func onConstruct() {
            
            v_bc = TSView()
            v_bc.onDraw = { (rect) in
                let gradient = CAGradientLayer()
                let firstColor = self.colorProvider.hexToUIColor(hexString: "33e1ff")
                let lastColor = self.colorProvider.hexToUIColor(hexString: "3399ff")

                gradient.colors = [firstColor.cgColor,lastColor.cgColor]
                gradient.startPoint = CGPoint(x: 0, y: 0)
                gradient.endPoint = CGPoint(x: 1, y: 1)
                gradient.frame = rect

                self.v_bc.layer.addSublayer(gradient)
            }
            self.addSubview(v_bc)
            
            iv_logo = TSImageView()
            iv_logo.image = imageProvider.getLogo()
            self.addSubview(iv_logo)
            
            let items = [
                TutorialSliderItem(image: imageProvider.getIzmirTutorial(), title: "En Taksi'ye Hoşgeldiniz!", body: "Güvenilir yolculuğun sırrını keşfedin. Bir tık ile Taksim'i nasıl çağırırım?"),
                TutorialSliderItem(image: imageProvider.getMapTutorial(), title: "Konum seçimi", body: "Gitmek istediğiniz adresi ilgili alana yazarak kolayca belirleyebilirsiniz."),
                TutorialSliderItem(image: imageProvider.getWalletTutorial(), title: "Ödeme yöntemi", body: "Sistemimizde birden çok ödeme yöntemi ile güvenle ödemenizi yapabilirsiniz."),
                TutorialSliderItem(image: imageProvider.getSafetyTutorial(), title: "Güvenli yolculuğun tadını çıkarın!", body: "Taksinizi çağırın, ailecek güvenli ve kaliteli yolculuğun tadını çıkarın.")
            ]
            
            pageControl = TutorialPageControl()
            pageControl.backgroundColor = UIColor.clear
            pageControl.pageIndicatorTintColor = UIColor.lightText
            pageControl.currentPageIndicatorTintColor = UIColor.white
            pageControl.currentPage = 0
            
            slider = TutorialSlider(items: items, pageControl: pageControl, layout: self, spacePages: 20)
            slider.onPageChanged = {
                
                if (self.pageControl.currentPage == 3) {
                    self.btn.isHidden = false
                }
                
            }
        
            btn = Button()
            btn.setTitle("İleri", for: .normal)
            btn.isHidden = true
            
            self.addSubview(btn)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: v_bc, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_bc, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_bc, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_bc, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 140))
            set.append(NSLayoutConstraint(item: iv_logo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 70))
            
            set.append(NSLayoutConstraint(item: btn, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: btn, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
            set.append(NSLayoutConstraint(item: btn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10))
            
            set.append(NSLayoutConstraint(item: pageControl, attribute: .top, relatedBy: .equal, toItem: slider, attribute: .bottom, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: btn, attribute: .top, multiplier: 1, constant: -10))
            
            set.append(NSLayoutConstraint(item: slider, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//            set.append(NSLayoutConstraint(item: slider, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: slider, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: iv_logo, attribute: .bottom, multiplier: 1, constant: 10))

        }
        
    }
    
}
