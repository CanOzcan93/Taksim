//
//  HelpWebViewLayout.swift
//  Taksim
//
//  Created by Can Özcan on 10.07.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension About {
    
    public class HelpWebViewLayout: TSLayout {
        
        // Fields
        
        public var wv: CoreWebView!
        private var btn_back: TSImageView!
        
        // Actions
        
        public var onBackButtonClicked: Action!
        open func getURL() -> String? { return nil }
        
        public override func onConstruct() {
            
            self.wv = CoreWebView()
            if let str_url = getURL() {
                let url = URL(string: str_url)
                if let def_url = url {
                    let urlReq = URLRequest(url: def_url)
                    self.wv.load(urlReq)
                }
            }
            self.addSubview(self.wv)
            
            self.btn_back = TSImageView()
            self.btn_back.image = imageProvider.getLeftArrow()
            self.btn_back.onTap {
                self.onBackButtonClicked?()
            }
            self.addSubview(self.btn_back)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: wv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: wv, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: wv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: wv, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
            set.append(NSLayoutConstraint(item: btn_back, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 39))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 12))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
            set.append(NSLayoutConstraint(item: btn_back, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
            
            
        }
        
    }
    
}
