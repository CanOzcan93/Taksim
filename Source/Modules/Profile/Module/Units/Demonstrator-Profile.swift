//
//  Demonstrator-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Profile {
    
    public class Demonstrator: CoreDemonstrator {
        
        private var module: Module!
        
        private var factory: Factory!
        
        private var sheetFactory: SheetFactory!
        private var transitionFactory: TransitionFactory!
        
        public required init() {
            
            module = Module.getInstance()
            
            factory = module.factory
            
            sheetFactory = factory.sheetFactory
            transitionFactory = factory.transitionFactory
            
        }
        
        public func toMainSheet() {
            
            sheet = sheetFactory.getMainSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toPhotoShootSheet() {
            let photoSheet = sheetFactory.getPhotoShootSheet()
            sheet = photoSheet
            transition = transitionFactory.getFromRightToLeft()
            
            let photoLayout = photoSheet.view as! PhotoShootLayout
            photoSheet.mediaManager.turnOnCaptureSessionAndCreatePreviewLayer(compound: photoLayout.v_camera)
            
            present()
            
        }
        
        
        public func goBack() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
        }
        
    }
    
}
