//
//  Sheet.swift
//  Taksim
//
//  Created by Can Özcan on 25.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

extension Main {
    
    open class Sheet<LayoutType: TSLayout>: TSSheet<LayoutType> {
        
        private var module: Module!

        open var demonstrator: Demonstrator!

        open override func onInjection() {

            super.onInjection()

            module = Module.getInstance()

            demonstrator = module.demonstrator

        }

        open override func viewDidAppear(_ animated: Bool) {

            super.viewDidAppear(animated)

            demonstrator.setCurrent(vc: self)

        }
        
    }
    
}
