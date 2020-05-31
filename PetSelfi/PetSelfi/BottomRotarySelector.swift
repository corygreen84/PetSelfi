//
//  BottomRotarySelector.swift
//  PetSelfi
//
//  Created by Cory Green on 5/31/20.
//  Copyright © 2020 Cory Green. All rights reserved.
//

import UIKit

class BottomRotarySelector: NSObject {
    
    var passedInView:UIView?
    
    // the box at the bottom //
    var bottomBox:UIView?
    
    // the button to expand and record //
    var centerButton:UIButton?
    
    // the rotary dial //
    var rotary:UIView?
    
    var buttonPressed:Bool = false
    
    init(view:UIView) {
        super.init()
        self.passedInView = view
        
        self.drawOrangeBar()
        self.createCenterButton()
        self.createRotaryDial()
    }
    
    
    func drawOrangeBar() {
        bottomBox = UIView(frame: CGRect(x: 0.0, y: (self.passedInView?.frame.origin.y)! + ((self.passedInView?.frame.size.height)! - 100.0), width: (self.passedInView?.frame.size.width)!, height: 100.0))
        bottomBox!.backgroundColor = Colors.sharedInstance.orangeColor
        
        self.passedInView?.addSubview(bottomBox!)
    }
    
    func createCenterButton(){
        centerButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0))
        let centerOfBottomBox = CGPoint(x: self.bottomBox!.center.x, y: self.bottomBox!.center.y)
        centerButton?.center = centerOfBottomBox
        centerButton?.center.y = (centerButton?.center.y)! - 60.0
        centerButton?.layer.cornerRadius = (centerButton?.frame.size.height)! / 2.0
        centerButton?.backgroundColor = UIColor.black
        centerButton?.addTarget(self, action: #selector(self.centerButtonOnClick(sender:)), for: UIControl.Event.touchUpInside)
        
        
        self.passedInView?.addSubview(centerButton!)
        
    }
    
    
    @objc func centerButtonOnClick(sender:AnyObject){
        buttonPressed = !buttonPressed
        if(buttonPressed){
            self.expandRotaryDial()
        }else{
            self.retractRotaryDial()
        }
    }
    
    func expandRotaryDial(){
        UIView.animate(withDuration: 0.2, animations: {
            self.rotary?.frame.size.width = 220.0
            self.rotary?.frame.size.height = 220.0
            let centerButtonCenter = CGPoint(x: self.centerButton!.center.x, y: self.centerButton!.center.y)
            self.rotary?.center = centerButtonCenter
            self.rotary!.layer.cornerRadius = self.rotary!.frame.size.height / 2.0

            
        }) { (complete) in
            print(complete)
        }
    }
    
    func retractRotaryDial(){
        UIView.animate(withDuration: 0.2, animations: {
            
            self.rotary?.frame.size.width = 0.0
            self.rotary?.frame.size.height = 0.0
            let centerButtonCenter = CGPoint(x: self.centerButton!.center.x, y: self.centerButton!.center.y)
            self.rotary?.center = centerButtonCenter
            self.rotary!.layer.cornerRadius = self.rotary!.frame.size.height / 2.0
        }) { (complete) in
            print(complete)
        }
    }
    
    
    
    
    
    
    func createRotaryDial(){
        rotary = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        let centerButtonCenter = CGPoint(x: centerButton!.center.x, y: centerButton!.center.y)
        rotary?.center = centerButtonCenter
        rotary!.backgroundColor = UIColor.blue
        
        self.passedInView?.addSubview(rotary!)
        self.passedInView?.bringSubviewToFront(centerButton!)
    }

}
