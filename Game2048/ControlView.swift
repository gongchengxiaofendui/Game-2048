//
//  ControlView.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//
import UIKit

class ControlView
{
    let defaultFrame = CGRectMake(0,0, 100, 30)
    
    func createButton(title:String,action:Selector,sender:UIViewController) -> UIButton
    {
        let button = UIButton(frame: defaultFrame)
        
        button.backgroundColor = UIColor.redColor()
        button.setTitle(title, forState:.Normal)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        button.addTarget(sender, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    func createTextField(value:String,action:Selector
        ,sender:UITextFieldDelegate) -> UITextField
    {
        let textField = UITextField(frame: defaultFrame)
        textField.backgroundColor = UIColor.clearColor()
        textField.textColor = UIColor.blackColor()
        textField.text = value
        textField.borderStyle = UITextBorderStyle.RoundedRect
        
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = sender
        
        return textField
    }
    
    func createLabel(title:String) -> UILabel
    {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor.whiteColor()
        label.text = title
        label.frame = defaultFrame
        label.font = UIFont(name: "Helveticaneue-Bold", size: 16)
        return label
    }
    
    func createSegment(items:[String],action:Selector,sender:UIViewController) -> UISegmentedControl
    {
        let segment = UISegmentedControl(items: items)
        segment.frame = defaultFrame
       // segment.segmentedControlStyle = UISegmentedControlStyleBordered
        segment.momentary = false
        segment.addTarget(sender, action: action, forControlEvents: UIControlEvents.ValueChanged)
        
        return segment
    }
}
