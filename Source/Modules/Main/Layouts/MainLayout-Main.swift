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
        private var iv_menu: TSImageView!
        public var i_route: RouteInput!
        
        public var o_menu: MenuOverlay!
        public var o_quickorder: QuickOrderOverlay!
        public var o_estimation: EstimationOverlay!
        public var o_loading: LoadingOverlay!
        
//        private var pu_binary: CancellationPopup!
        public var pu_review: ReviewPopup!
        
        private var locationFirst: CoreCoordinate!
        private var locationLast: CoreCoordinate!
        
        private var apiManager = TSSharepoint.getInstance().agency.manager?.apiManager
        
        // Implementation
        
        override public func onConstruct() {
            
            super.onConstruct()
            
            self.mv = TSMapView(layout: self, initialCoordinate: CoreCoordinate(latitude: 38.4291513, longitude: 27.139717), initialZoom: 14)
            
            self.i_route = RouteInput(layout: self)
            
            self.iv_menu = TSImageView()
            self.iv_menu.image = imageProvider.getHamburgerMenu()
            self.iv_menu.onTap {
                self.o_menu.show()
            }
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
          
        }
        
    }
    
}
