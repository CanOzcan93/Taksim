//
//  NotificationLayout-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class NotificationsLayout: PostLogin.WavyLayout {

        private var tv_soon: TSTextView!
        
        public override func onHeading() -> String {
            return lexiconProvider.get("notifications")
        }
        
        public override func onConstruct() {
            
            super.onConstruct()
            
            self.tv_soon = TSTextView()
            self.tv_soon.textAlignment = .center
            self.tv_soon.font = fontProvider.getSemiboldLargest()
            self.tv_soon.text = "Yakında Eklenecektir"
            
            self.addSubview(self.tv_soon)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            super.onConstrain(set: &set)
            
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -95))
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_soon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
        }
        
//        private var lv: NotificationList!
//
//        public override func onHeading() -> String {
//            return lexiconProvider.get("notifications")
//        }
//
//        public override func onConstruct() {
//
//            super.onConstruct()
//
//            let items = [
//                NotificationListItem(),
//                NotificationListItem(),
//                NotificationListItem(),
//                NotificationListItem()
//            ]
//
//            self.lv = NotificationList(items: items)
//
//            self.addSubview(self.lv)
//
//        }
//
//        public override func onConstrain(set: inout [NSLayoutConstraint]) {
//
//            super.onConstrain(set: &set)
//
//            set.append(NSLayoutConstraint(item: lv, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
//            set.append(NSLayoutConstraint(item: lv, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -95))
//            set.append(NSLayoutConstraint(item: lv, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
//            set.append(NSLayoutConstraint(item: lv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//
//        }
        
    }

}
