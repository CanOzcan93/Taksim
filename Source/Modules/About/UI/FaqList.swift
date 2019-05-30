//
//  FaqList.swift
//  Taksim
//
//  Created by Can Özcan on 15.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension About {
    
    public class FaqList: TSCompoundView {
        
        private var sv: UIScrollView!
        private var items: [FaqListItem]!
        
        public override func onConstruct(layout: CoreLayout) {
            
            self.sv = UIScrollView()
            self.sv.translatesAutoresizingMaskIntoConstraints = false
            
            self.items = [FaqListItem]()
            
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            self.items.append(FaqListItem(layout: layout, scroll: sv, title: "Yakında Eklenecektir", text: "Yakında Eklenecektir"))
            
            
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
            set.append(NSLayoutConstraint(item: items.last?.v_background, attribute: .bottom, relatedBy: .equal, toItem: sv, attribute: .bottom, multiplier: 1, constant: 0))
            
        }
        
    }
    
}
