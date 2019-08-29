//
//  MainLayout.swift
//  Taksim
//
//  Created by Can Özcan on 25.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//
import Core
import GoogleMaps

extension Main {
    
    public class MainLayout: TSLayout {
        
        // Fields
        
        public var mv: TSMapView!
        public var iv_menu: TSImageView!
        public var i_route: RouteInput!
        
        public var o_menu: MenuOverlay!
        public var o_quickorder: QuickOrderOverlay!
        public var o_estimation: EstimationOverlay!
        public var o_loading: LoadingOverlay!
        
//        private var pu_binary: CancellationPopup!
        public var pu_review: ReviewPopup!
        public var btn_curLoc: TSButton!
        
        private var locationFirst: CoreCoordinate!
        private var locationLast: CoreCoordinate!
        
        private var apiManager = TSSharepoint.getInstance().agency.manager?.apiManager
        
        // Implementation
        
        override public func onConstruct() {
            
            super.onConstruct()
            
            self.mv = TSMapView(layout: self, initialCoordinate: CoreCoordinate(latitude: 38.4291513, longitude: 27.139717), initialZoom: 14)
            
            self.i_route = RouteInput(layout: self)
            
            self.btn_curLoc = TSButton()
            self.btn_curLoc.setImage(imageProvider.getCurrentLocationIcon(), for: .normal)
            self.btn_curLoc.backgroundColor = .clear
            var btnDrawn = false
            self.btn_curLoc.onDraw = { rect in
                if !btnDrawn {
                    let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2).cgPath
                    let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: 1, left: 1, bottom: -1, right: -1)), cornerRadius: (rect.height/2)).cgPath
                    
                    let layer = CAShapeLayer()
                    layer.path = path
                    layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                    
                    layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                    layer.shadowPath = shadowPath
                    layer.shadowOffset = .zero
                    layer.shadowOpacity = 0.4
                    layer.shadowRadius = 1
                    
                    self.btn_curLoc.layer.insertSublayer(layer, at: 0)
                    self.btn_curLoc.clipsToBounds = false
                    btnDrawn = true
                }
            }
            self.addSubview(btn_curLoc)
            
            self.iv_menu = TSImageView()
            self.iv_menu.image = imageProvider.getHamburgerMenu()
            
            self.addSubview(iv_menu)
            
            self.o_estimation = EstimationOverlay(layout: self)
            self.o_quickorder = QuickOrderOverlay(layout: self)
            self.o_menu = MenuOverlay(layout: self)
            self.o_loading = LoadingOverlay(layout: self)
            
            self.pu_review = ReviewPopup(layout: self)
        
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: iv_menu, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_menu, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
            set.append(NSLayoutConstraint(item: iv_menu, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_menu, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
            
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -190))
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            set.append(NSLayoutConstraint(item: btn_curLoc, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
          
        }
        
    }
    
}
