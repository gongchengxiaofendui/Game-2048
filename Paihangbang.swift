//
//  ScoreView.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

protocol PaihangbangViewProtocol
{
    func changei(value s:Int)
}

class PaihangbangView:UIView, PaihangbangViewProtocol
{
    var label:UILabel
    var defaultFram = CGRectMake(0, 0, 90, 30)
    
    var i:Int = 0{
        didSet{
            label.text = "第\(i)名"
        }
    }
    
    
    init()
    {
        label = UILabel(frame:defaultFram)
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame:defaultFram)
        
        backgroundColor = UIColor.yellowColor()
        label.font = UIFont(name: "微软雅黑", size: 16)
        label.textColor = UIColor.blackColor()
        self.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changei(value s: Int) {
        i = s
    }
}

