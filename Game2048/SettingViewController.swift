//
//  SettingViewController.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

class SettingViewController:UIViewController,UITextFieldDelegate
{
    var mainView:MainViewController
    
    var txtNum:UITextField!
    
    var segDimension:UISegmentedControl!
    
    init(mainveiw:MainViewController)
    {
        self.mainView = mainveiw
        super.init(nibName:nil,bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupController()
    }
    
    func setupController()
    {
        let cv = ControlView()
        
        txtNum = cv.createTextField(String(self.mainView.maxnumber), action: Selector("numChanged"), sender: self)
        
        
        txtNum.frame.origin.x = 50
        txtNum.frame.origin.y = 100
        txtNum.frame.size.width = 200
        txtNum.returnKeyType = UIReturnKeyType.Done
        
        self.view.addSubview(txtNum)
        
        segDimension = cv.createSegment(["3*3","4*4","5*5"], action:"dimensionChanged:", sender: self)
        
        segDimension.frame.origin.x = 50
        segDimension.frame.origin.y = 200
        segDimension.frame.size.width = 200
        
        self.view.addSubview(segDimension)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        print("num Changed!")
        
        if(textField.text != "\(mainView.maxnumber)")
        {
            let num = Int(textField.text!)
            mainView.maxnumber = num!
        }
        return true
    }
    
    func dimensionChanged(sender:SettingViewController)
    {
        var segVals = [3,4,5]
        mainView.dimension = segVals[segDimension.selectedSegmentIndex]
        mainView.resetTapped()
    }
}
