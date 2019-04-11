//
//  LoadingOverlay.swift
//  Taksim
//
//  Created by Can Özcan on 5.04.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

public class LoadingOverlay: TSCompoundView {
    
    private var v_shade: TSView!
    private var iv: TSImageView!
    
    private var hiddenShadeConstraint: NSLayoutConstraint!
    private var visibleShadeConstraint: NSLayoutConstraint!
    
    public override func onConstruct(layout: CoreLayout) {
        
        constructShadeView()
        constructAnimatedImage()
        
    }
    
    public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
        
        constrainShadeView(set: &set, layout: layout)
        constrainAnimatedImage(set: &set, layout: layout)
        
    }
    
    private func constructShadeView() {
        
        self.v_shade = TSView()
        self.v_shade.backgroundColor = colorProvider.getBlackSoft()
        self.v_shade.onTap {
            self.hide()
        }
        
        self.packView(self.v_shade)
        
    }
    
    private func constructAnimatedImage() {
        
        var images = [UIImage]()
        
        for i in 0...19 {
            images.append(UIImage(named: "loading_\(i).png")!)
        }
        
        self.iv = TSImageView()
        self.iv.animationImages = images
        self.iv.animationDuration = 1.0
        
        self.packView(self.iv)
        
    }
    
    private func constrainShadeView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
        
        self.hiddenShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .right, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0)
        self.visibleShadeConstraint = NSLayoutConstraint(item: v_shade, attribute: .centerX, relatedBy: .equal, toItem: layout, attribute: .centerX, multiplier: 1, constant: 0)
        
        set.append(hiddenShadeConstraint)
        set.append(NSLayoutConstraint(item: v_shade, attribute: .centerY, relatedBy: .equal, toItem: layout, attribute: .centerY, multiplier: 1, constant: 0))
        set.append(NSLayoutConstraint(item: v_shade, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
        set.append(NSLayoutConstraint(item: v_shade, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 1, constant: 0))
        
    }
    
    private func constrainAnimatedImage(set: inout [NSLayoutConstraint], layout: CoreLayout) {
        
        set.append(NSLayoutConstraint(item: iv, attribute: .centerX, relatedBy: .equal, toItem: v_shade, attribute: .centerX, multiplier: 1, constant: 0))
        set.append(NSLayoutConstraint(item: iv, attribute: .centerY, relatedBy: .equal, toItem: layout, attribute: .centerY, multiplier: 1, constant: 0))
        set.append(NSLayoutConstraint(item: iv, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 0.2, constant: 0))
        set.append(NSLayoutConstraint(item: iv, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 0.2, constant: 0))
        
    }
    
    public func show() {
        
        self.iv.startAnimating()
        
        self.shift(from: hiddenShadeConstraint, to: visibleShadeConstraint)
        
        self.relayout()
        
    }
    
    public func hide() {
        
        self.shift(from: self.visibleShadeConstraint, to: self.hiddenShadeConstraint)
        
        self.relayout()
        
        self.iv.stopAnimating()
        
    }
    
}
