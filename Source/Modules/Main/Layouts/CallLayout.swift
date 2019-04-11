//
//  CallLayout.swift
//  Taksim
//
//  Created by E.E.E. on 31.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class CallLayout: TSLayout {
        
        private var v_background: TSView!
        
        private var v_pulse: TSView!
        private var iv_profile: TSImageView!
        
        private var tv_name: TSTextView!
        private var tv_plate: TSTextView!
        
        private var tv_status: TSTextView!
        
        private var iv_hang_up: TSImageView!
        
        
        public var onHangUp: Action!
        
        public override func onConstruct() {
            
            v_background = TSView()
            v_background.onDraw = { (rect) in
                
                if self.v_background.layer.sublayers == nil {
                
                    let gradient = CAGradientLayer()
                    let firstColor = self.colorProvider.hexToUIColor(hexString: "33e1ff")
                    let lastColor = self.colorProvider.hexToUIColor(hexString: "3399ff")
                    
                    gradient.colors = [firstColor.cgColor,lastColor.cgColor]
                    gradient.startPoint = CGPoint(x: 0, y: 0)
                    gradient.endPoint = CGPoint(x: 1, y: 1)
                    gradient.frame = rect
                    
                    self.v_background.layer.addSublayer(gradient)
                    
                }
                
            }
            self.addSubview(v_background)
            
            v_pulse = TSView()
            v_pulse.backgroundColor = UIColor.clear
            v_pulse.onDraw = { (rect) in
                self.createPulse(rect: rect, pulseLineCount: 3, duration: 1)
            }
            self.addSubview(v_pulse)
            
            iv_profile = TSImageView()
            iv_profile.image = UIImage(named: "ic_avatar")
            self.addSubview(iv_profile)
            
            tv_name = TSTextView()
            tv_name.text = "Tahsin Yılmaz"
            tv_name.textAlignment = .center
            tv_name.textColor = UIColor.white
            tv_name.font = tv_name.font.withSize(25)
            self.addSubview(tv_name)
            
            tv_plate = TSTextView()
            tv_plate.text = "34 FC 1876"
            tv_plate.textAlignment = .center
            tv_plate.textColor = UIColor.white
            tv_plate.font = tv_plate.font.withSize(18)
            self.addSubview(tv_plate)
            
            tv_status = TSTextView()
            tv_status.text = "Bağlandı"
            tv_status.textAlignment = .center
            tv_status.textColor = UIColor.white
            tv_status.font = fontProvider.getRegularMedium()
            self.addSubview(tv_status)
            
            iv_hang_up = TSImageView()
            iv_hang_up.image = imageProvider.getHangUpIcon()
            iv_hang_up.onTap {
                self.onHangUp()
            }
            self.addSubview(iv_hang_up)
            
        }
        
        public override func onConstrain(set: inout [NSLayoutConstraint]) {
            
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_background, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            
            set.append(NSLayoutConstraint(item: iv_profile, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_profile, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 160))
            set.append(NSLayoutConstraint(item: iv_profile, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 130))
            set.append(NSLayoutConstraint(item: iv_profile, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 130))
            
            set.append(NSLayoutConstraint(item: v_pulse, attribute: .centerX, relatedBy: .equal, toItem: iv_profile, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_pulse, attribute: .centerY, relatedBy: .equal, toItem: iv_profile, attribute: .centerY, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: v_pulse, attribute: .width, relatedBy: .equal, toItem: iv_profile, attribute: .width, multiplier: 2, constant: 0))
            set.append(NSLayoutConstraint(item: v_pulse, attribute: .height, relatedBy: .equal, toItem: iv_profile, attribute: .height, multiplier: 2, constant: 0))
            
            set.append(NSLayoutConstraint(item: tv_name, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .top, relatedBy: .equal, toItem: iv_profile, attribute: .bottom, multiplier: 1, constant: 100))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 170))
            set.append(NSLayoutConstraint(item: tv_name, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 34))
            
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .top, relatedBy: .equal, toItem: tv_name, attribute: .bottom, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 107))
            set.append(NSLayoutConstraint(item: tv_plate, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 25))
            
            set.append(NSLayoutConstraint(item: tv_status, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: tv_status, attribute: .top, relatedBy: .equal, toItem: tv_plate, attribute: .bottom, multiplier: 1, constant: 20))
            set.append(NSLayoutConstraint(item: tv_status, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 73))
            set.append(NSLayoutConstraint(item: tv_status, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 22))
            
            set.append(NSLayoutConstraint(item: iv_hang_up, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            set.append(NSLayoutConstraint(item: iv_hang_up, attribute: .top, relatedBy: .equal, toItem: tv_status, attribute: .bottom, multiplier: 1, constant: 30))
            set.append(NSLayoutConstraint(item: iv_hang_up, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 60))
            set.append(NSLayoutConstraint(item: iv_hang_up, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 60))
            
        }
        
        private func createPulse(rect: CGRect, pulseLineCount: UInt, duration: Double) {
            
            self.v_pulse.layer.sublayers?.removeAll()
            
            createPulseLine(rect: rect, remaining: pulseLineCount, timing: duration/Double(pulseLineCount), duration: duration)
            
        }
        
        private func createPulseLine(rect: CGRect, remaining: UInt, timing: Double, duration: Double) {
            
            if remaining != 0 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + timing) {
                    
                    let circularPath = UIBezierPath(arcCenter: .zero, radius: rect.size.width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
                    
                    let pulseLayer = CAShapeLayer()
                    pulseLayer.path = circularPath.cgPath
                    pulseLayer.lineWidth = 2
                    pulseLayer.fillColor = UIColor.clear.cgColor
                    pulseLayer.strokeColor = UIColor.white.cgColor
                    pulseLayer.lineCap = .round
                    pulseLayer.position = CGPoint(x: rect.size.width/2, y: rect.size.width/2)
                    self.v_pulse.layer.addSublayer(pulseLayer)
                    
                    let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
                    pulseAnimation.duration = duration
                    pulseAnimation.fromValue = 0.5
                    pulseAnimation.toValue = 1
                    pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
                    pulseAnimation.repeatCount = .greatestFiniteMagnitude
                    
                    pulseLayer.add(pulseAnimation, forKey: "scale")
                    
                    let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
                    opacityAnimation.duration = duration
                    opacityAnimation.fromValue = 0.9
                    opacityAnimation.toValue = 0
                    opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
                    opacityAnimation.repeatCount = .greatestFiniteMagnitude
                    
                    pulseLayer.add(opacityAnimation, forKey: "opacity")
                    
                    self.createPulseLine(rect: rect, remaining: remaining-1, timing: timing, duration: duration)
                    
                }
                
            }
            
        }
        
    }
    
}
