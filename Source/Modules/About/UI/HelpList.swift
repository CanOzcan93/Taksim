//
//  AboutList.swift
//  Taksim
//
//  Created by Erhan Emre Eroğlu on 14.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension About {
    
    public class HelpList: TSCompoundView {
        
        private var sv: UIScrollView!
        private var items: [HelpListItem]!
        
        public override func onConstruct(layout: CoreLayout) {
            
            self.sv = UIScrollView()
            self.sv.translatesAutoresizingMaskIntoConstraints = false
            
            self.items = [HelpListItem]()
            
            self.items.append(HelpListItem(layout: layout, scroll: sv, title: "Hakkımızda", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
            self.items.append(HelpListItem(layout: layout, scroll: sv, title: "Ödeme Politikası", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
            self.items.append(HelpListItem(layout: layout, scroll: sv, title: "Kullanım Koşulları", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
            self.items.append(HelpListItem(layout: layout, scroll: sv, title: "Gizlilik Politikası", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
            self.items.append(HelpListItem(layout: layout, scroll: sv, title: "Geri Bildirim", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
            
            self.packView(sv)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: sv, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: sv, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: sv, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 1, constant: -90))
            set.append(NSLayoutConstraint(item: sv, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .top, multiplier: 1, constant: 90))
            
            
            set.append(NSLayoutConstraint(item: items[0].v_background, attribute: .top, relatedBy: .equal, toItem: sv, attribute: .top, multiplier: 1, constant: 0))
            
            for i in 1...(items.count - 1) {
                set.append(NSLayoutConstraint(item: items[i].v_background, attribute: .top, relatedBy: .equal, toItem: items[i - 1].v_background, attribute: .bottom, multiplier: 1, constant: -25))
            }
            
        }
        
    }
    
}
