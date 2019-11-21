//
//  GeneralYearPicker-PostLogin.swift
//  Taksim
//
//  Created by Can Özcan on 21.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension PostLogin {
    
    public class GeneralYearPicker: TSCompoundView {
        
        // Internal Fields
        public var v_inputBackground: TSView!
        public var ti: TSTextInput!
        public var v_pickerBackground: TSView!
        public var picker: TSMonthYearPicker!
        public var v_doneBackground: TSView!
        public var btn_done: TSTextView!
        
        private var hiddenConstraint: NSLayoutConstraint!
        private var visibleConstraint: NSLayoutConstraint!
        
        // MARK: Internal Functions
        
        public var onBackButtonClicked: Action!
        
        /*
         -
         -
         // MARK: Construction
         -
         -
         */
        
        public override func onConstruct(layout: CoreLayout) {
            
            super.onConstruct(layout: layout)
            constructInputBackgroundView()
            constructTextInput(layout: layout)
            constructPickerBackgroundView(layout: layout)
//            constructDoneBackgroundView(layout: layout)
            constructButtonDone(layout: layout)
            constructPicker(layout: layout)
            
        }
        
        private func constructInputBackgroundView() {
            
            self.v_inputBackground = TSView()
            self.v_inputBackground.layer.isOpaque = false
            self.v_inputBackground.onDraw = { rect in
                self.v_inputBackground.layer.sublayers?.removeAll()
                
                let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/8).cgPath
                let shadowPath = UIBezierPath(roundedRect: rect.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -1, right: 0)), cornerRadius: 8).cgPath
                
                let layer = CAShapeLayer()
                layer.path = path
                layer.fillColor = self.colorProvider.getWhiteFull().cgColor
                layer.lineWidth = 1
                layer.shadowColor = self.colorProvider.getBlackFull().cgColor
                layer.shadowPath = shadowPath
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0.1
                layer.shadowRadius = 8
                layer.masksToBounds = false
                
                self.v_inputBackground.layer.insertSublayer(layer, at: 0)
            }
            
            self.packView(self.v_inputBackground)
            
        }
        
        private func constructTextInput(layout: CoreLayout) {
            
            self.ti = TSTextInput()
            self.ti.font = fontProvider.getRegularMedium()
            self.ti.textColor = colorProvider.getBlackFull()
            self.ti.setPlaceholder(text: "MM / YY")

            self.ti.activateMovement(layout: layout)
            
            self.packView(self.ti)
            
        }
        
        private func constructPickerBackgroundView(layout: CoreLayout) {
                    
            self.v_pickerBackground = TSView()
            self.v_pickerBackground.backgroundColor = colorProvider.getDarkGray()
            
            self.packView(self.v_pickerBackground)
            
                    
        }
        
        private func constructDoneBackgroundView(layout: CoreLayout) {
                    
            self.v_doneBackground = TSView()
            self.v_doneBackground.backgroundColor = .white
            
            
            self.packView(self.v_pickerBackground)
            
                    
        }
        
        private func constructButtonDone(layout: CoreLayout) {
                    
            self.btn_done = TSTextView()
            self.btn_done.text = "Done"
            self.btn_done.textColor = colorProvider.getNormalBlue()
            self.btn_done.onTap {
                self.hide()
            }
            
            
            self.packView(self.btn_done)
                    
        }
        
        private func constructPicker(layout: CoreLayout) {
                    
            self.picker = TSMonthYearPicker()
            self.picker.translatesAutoresizingMaskIntoConstraints = false
            self.picker.onDateSelected = { (month, year) in
                
                self.ti.text = String(format: "%02d/%d", month, year%1000)
                
            }
            self.packView(self.picker)
                    
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            super.onConstrain(set: &set, layout: layout)
            constrainInputBackgroundView(set: &set, layout: layout)
            constrainTextInput(set: &set, layout: layout)
            constrainPickerBackgroundView(set: &set, layout: layout)
//            constrainDoneBackgroundView(set: &set, layout: layout)
            constrainButtonDone(set: &set, layout: layout)
            constrainPicker(set: &set, layout: layout)
            
        }
        
        private func constrainInputBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 0.4, constant: 0))
            set.append(NSLayoutConstraint(item: v_inputBackground, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
            
        }
        
        private func constrainTextInput(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            set.append(NSLayoutConstraint(item: ti, attribute: .centerY, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .centerX, relatedBy: .equal, toItem: v_inputBackground, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: ti, attribute: .width, relatedBy: .equal, toItem: v_inputBackground, attribute: .width, multiplier: 1, constant: -40))
            set.append(NSLayoutConstraint(item: ti, attribute: .height, relatedBy: .equal, toItem: v_inputBackground, attribute: .height, multiplier: 1, constant: 0))
            
        }
        
        private func constrainPickerBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
            
            hiddenConstraint = NSLayoutConstraint(item: v_pickerBackground, attribute: .top, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
            visibleConstraint = NSLayoutConstraint(item: v_pickerBackground, attribute: .bottom, relatedBy: .equal, toItem: layout, attribute: .bottom, multiplier: 1, constant: 0)
                   
            set.append(NSLayoutConstraint(item: v_pickerBackground, attribute: .left, relatedBy: .equal, toItem: layout, attribute: .left, multiplier: 1, constant: 0))
            set.append(hiddenConstraint)
            set.append(NSLayoutConstraint(item: v_pickerBackground, attribute: .width, relatedBy: .equal, toItem: layout, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_pickerBackground, attribute: .height, relatedBy: .equal, toItem: layout, attribute: .height, multiplier: 0.4, constant: 0))
           
        }
        
        private func constrainDoneBackgroundView(set: inout [NSLayoutConstraint], layout: CoreLayout) {
                    
            set.append(NSLayoutConstraint(item: v_doneBackground, attribute: .top, relatedBy: .equal, toItem: v_pickerBackground, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_doneBackground, attribute: .centerX, relatedBy: .equal, toItem: v_pickerBackground, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_doneBackground, attribute: .width, relatedBy: .equal, toItem: v_pickerBackground, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_doneBackground, attribute: .height, relatedBy: .equal, toItem: v_pickerBackground, attribute: .height, multiplier: 0.2, constant: 0))
            
                    
        }
        
        private func constrainButtonDone(set: inout [NSLayoutConstraint], layout: CoreLayout) {
                    
            set.append(NSLayoutConstraint(item: btn_done, attribute: .right, relatedBy: .equal, toItem: v_pickerBackground, attribute: .right, multiplier: 1, constant: -5))
            set.append(NSLayoutConstraint(item: btn_done, attribute: .top, relatedBy: .equal, toItem: v_pickerBackground, attribute: .top, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: btn_done, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50))
            set.append(NSLayoutConstraint(item: btn_done, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 30))
                    
        }
       
        private func constrainPicker(set: inout [NSLayoutConstraint], layout: CoreLayout) {
           
            set.append(NSLayoutConstraint(item: picker, attribute: .centerX, relatedBy: .equal, toItem: v_pickerBackground, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: picker, attribute: .bottom, relatedBy: .equal, toItem: v_pickerBackground, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: picker, attribute: .top, relatedBy: .equal, toItem: btn_done, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: picker, attribute: .width, relatedBy: .equal, toItem: v_pickerBackground, attribute: .width, multiplier: 1, constant: 0))
           
        }
        
        public func show() {
            
            self.shift(from: self.hiddenConstraint, to: self.visibleConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }
        
        public func hide() {
            
            self.shift(from: self.visibleConstraint, to: hiddenConstraint)
            
            UIView.animate(withDuration: 0.4) {
                self.relayout()
            }
            
        }

    }
    
}
