//
//  NotificationListItem.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit
import Core

extension Profile {
    
    public class NotificationListItem: TSListItemView {
        
        private var tv: PostLogin.TextView!
        
        private var v_line: TSView!
        
        public override func onConstruct(wrapper: UIView, item: CoreView) {
            
            super.onConstruct(wrapper: wrapper, item: item)
            
            self.tv = PostLogin.TextView()
            self.tv.lineBreakMode = .byWordWrapping
            self.tv.numberOfLines = 2
            self.tv.text = "sdjhashj dklajsdlkas şkjdklşsjfklşa jfkadsşfjkfşasdjklş"
            
            item.addSubview(self.tv)
            
            self.v_line = TSView()
            self.v_line.backgroundColor = colorProvider.getGrayLighter()
            
            item.addSubview(self.v_line)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], wrapper: UIView, item: CoreView) {
            
            super.onConstrain(set: &set, wrapper: wrapper, item: item)
            
            set.append(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: wrapper, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .top, multiplier: 1, constant: 10))
            set.append(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: -10))
            
            set.append(NSLayoutConstraint(item: tv, attribute: .width, relatedBy: .equal, toItem: item, attribute: .width, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: tv, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: .bottom, multiplier: 1, constant: 0))
            
            set.append(NSLayoutConstraint(item: v_line, attribute: .width, relatedBy: .equal, toItem: wrapper, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line, attribute: .centerX, relatedBy: .equal, toItem: wrapper, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
            set.append(NSLayoutConstraint(item: v_line, attribute: .top, relatedBy: .equal, toItem: wrapper, attribute: .bottom, multiplier: 1, constant: 0))
            
        }
        
    }
    
}
