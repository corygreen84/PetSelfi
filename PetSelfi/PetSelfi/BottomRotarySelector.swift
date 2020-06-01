//
//  BottomRotarySelector.swift
//  PetSelfi
//
//  Created by Cory Green on 5/31/20.
//  Copyright © 2020 Cory Green. All rights reserved.
//

import UIKit

@objc protocol ReturnRotaryInfo{
    func longPress(status:Bool)
}

class BottomRotarySelector: NSObject {
    
    var passedInView:UIView?
    
    // the box at the bottom //
    var bottomBox:UIView?
    
    // the button to expand and record //
    var centerButton:UIButton?
    
    // the rotary dial //
    var rotary:UIView?
    
    var buttonPressed:Bool = false
    var longPress:Bool = false
    
    var delegate:ReturnRotaryInfo?
    
    init(view:UIView) {
        super.init()
        self.passedInView = view
        
        self.drawOrangeBar()
        self.createCenterButton()
        self.createRotaryDial()
    }
    
    
    // drawing the orange bar //
    func drawOrangeBar() {
        bottomBox = UIView(frame: CGRect(x: 0.0, y: (self.passedInView?.frame.origin.y)! + ((self.passedInView?.frame.size.height)! - 100.0), width: (self.passedInView?.frame.size.width)!, height: 100.0))
        bottomBox!.backgroundColor = Colors.sharedInstance.orangeColor
        bottomBox?.layer.zPosition = 2
        
        self.passedInView?.addSubview(bottomBox!)
    }
    
    // creating the center button //
    func createCenterButton(){
        centerButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        centerButton?.setImage(UIImage(named: "paw-circle"), for: UIControl.State.normal)
        let centerOfBottomBox = CGPoint(x: self.bottomBox!.center.x, y: self.bottomBox!.center.y)
        centerButton?.center = centerOfBottomBox
        centerButton?.center.y = (centerButton?.center.y)! - 60.0
        centerButton?.layer.cornerRadius = (centerButton?.frame.size.height)! / 2.0
        centerButton?.layer.zPosition = 3
        
        
        // tap gestures //
        let centerButtonTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(centerButtonOnClick))
        
        let centerButtonLongPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(centerButtonLongPress))
        
        
        // adding gesture recognizer to the main buttons //
        centerButton?.addGestureRecognizer(centerButtonTapGesture)
        centerButton?.addGestureRecognizer(centerButtonLongPressGesture)
        
        
        self.passedInView?.addSubview(centerButton!)
        
    }
    
    // center button on click //
    @objc func centerButtonOnClick(){
        buttonPressed = !buttonPressed
        if(buttonPressed){
            self.expandRotaryDial()
        }else{
            self.retractRotaryDial()
        }
    }
    
    
    @objc func centerButtonLongPress(gesture:UILongPressGestureRecognizer){
        if(gesture.state == .began){
            self.delegate?.longPress(status: true)
        }else if(gesture.state == .ended){
            self.delegate?.longPress(status: false)
        }
    }
    
    // expanding the rotary dial //
    func expandRotaryDial(){
        UIView.animate(withDuration: 0.2, animations: {
            self.rotary?.frame.size.width = 250.0
            self.rotary?.frame.size.height = 250.0
            let centerButtonCenter = CGPoint(x: self.centerButton!.center.x, y: self.centerButton!.center.y)
            self.rotary?.center = centerButtonCenter
            self.rotary!.layer.cornerRadius = self.rotary!.frame.size.height / 2.0
            
        }) { (complete) in
            // placement of the icons //
            let numberOfIcons = 6
            var angle = CGFloat(2 * Double.pi)
            let step = CGFloat(2 * Double.pi) / CGFloat(numberOfIcons)
            let center = CGPoint(x: (self.rotary?.center.x)!, y: (self.rotary?.center.y)!)
            
            for _ in 0...numberOfIcons{
                let xPosition = cos(angle) * 90 + center.x
                let yPosition = sin(angle) * 90 + center.y
                
                let animalButton = UIButton()
                animalButton.frame.size.height = 50.0
                animalButton.frame.size.width = 50.0
                animalButton.setImage(UIImage(named: "cat"), for: UIControl.State.normal)
                animalButton.center = CGPoint(x: xPosition, y: yPosition)
                animalButton.layer.cornerRadius = animalButton.frame.size.height / 2
                animalButton.layer.borderWidth = 2.0
                animalButton.layer.borderColor = Colors.sharedInstance.orangeColor.cgColor
                animalButton.layer.zPosition = 1
                animalButton.tag = 0
                
                
                self.passedInView?.addSubview(animalButton)
                
                angle += step
            }
        }
    }
    
    // retracting the rotary dial //
    func retractRotaryDial(){
        UIView.animate(withDuration: 0.2, animations: {
            self.rotary?.frame.size.width = 0.0
            self.rotary?.frame.size.height = 0.0
            let centerButtonCenter = CGPoint(x: self.centerButton!.center.x, y: self.centerButton!.center.y)
            self.rotary?.center = centerButtonCenter
            self.rotary!.layer.cornerRadius = self.rotary!.frame.size.height / 2.0
            
            
        }) { (complete) in
            
        }
    }
    
    
    
    
    
    // creating the rotary dial //
    func createRotaryDial(){
        rotary = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        let centerButtonCenter = CGPoint(x: centerButton!.center.x, y: centerButton!.center.y)
        rotary?.center = centerButtonCenter
        rotary?.backgroundColor = UIColor(red: 210.0/255.0, green: 215.0/255.0, blue: 211.0/255.0, alpha: 0.75)
        rotary?.layer.borderWidth = 5.0
        rotary?.layer.borderColor = Colors.sharedInstance.orangeColor.cgColor
        rotary?.layer.zPosition = 1
        
        self.passedInView?.addSubview(rotary!)
        self.passedInView?.bringSubviewToFront(centerButton!)
        
    }
}
