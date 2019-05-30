//
//  Sheet.swift
//  TS
//
//  Created by Can Özcan on 20.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

extension Authentication {
    
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
