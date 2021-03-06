//
//  PhotoShootSheet.swift
//  Taksim
//
//  Created by Can Özcan on 19.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

extension Profile {
    
    public class PhotoShootSheet: Sheet<PhotoShootLayout> {
        
        public override func onLayoutReady(layout: PhotoShootLayout) {
            
            layout.iv_back.onTap {
//                self.mediaManager.turnOffCaptureSession()
                self.demonstrator.goBack()
            }
            
            layout.iv_turn.onTap {
                self.mediaManager.getOrTurnCamera()
                self.mediaManager.updateImageInput()
            }
            
            layout.iv_shoot.onTap {
                self.mediaManager.shootPhoto(completition: { (image) in
                    self.exchangeFlow.letProfilePhotoChanged(photo: image)
                    self.demonstrator.goBack()
                })
            }
            
            mediaManager.turnOnCaptureSessionAndCreatePreviewLayer(compound: layout.v_camera)
            
        }
        
    }
}
