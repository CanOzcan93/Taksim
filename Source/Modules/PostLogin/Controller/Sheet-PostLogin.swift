//
//  Sheet=About.swift
//  Taksim
//
//  Created by Can Özcan on 11.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension PostLogin {
    
    open class Sheet<LayoutType: TSLayout>: TSSheet<LayoutType> {
        
        private var module: Module!
        
        open var demonstrator: Demonstrator!
        
        open override func viewDidLoad() {
            
            super.viewDidLoad()
            
            module = Module.getInstance()
            
            demonstrator = module.demonstrator
            
        }
        
        open override func viewDidAppear(_ animated: Bool) {
            
            super.viewDidAppear(animated)
            
            demonstrator.setCurrent(vc: self)
            
        }
        
    }
    
}
