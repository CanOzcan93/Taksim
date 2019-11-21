//
//  SearchLocationList.swift
//  Taksim
//
//  Created by Can Özcan on 14.08.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit

extension Main {
    
    public class SearchLocationList: TSListView<SearchLocationListItem> {
        
        public override func onInjection() {
            super.onInjection()
            self.backgroundColor = .white
            self.separatorStyle = .singleLine
            self.separatorInset.left = 0
            self.separatorColor = colorProvider.getGrayLighter()
            self.tableFooterView = TSView()
        }
                
    }
    
}
