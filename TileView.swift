//
//  TileView.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

class TileView:UIView{
    let colorMap = [
        2:UIColor(red: 250.0/255.0, green: 235.0/255.0, blue: 215.0/255.0, alpha: 1.0),
        4:UIColor(red: 255.0/255.0, green: 239.0/255.0, blue: 213.0/255.0, alpha: 1.0),
        8:UIColor(red: 255.0/255.0, green: 218.0/255.0, blue: 185.0/255.0, alpha: 1.0),
        16:UIColor(red: 255.0/255.0, green: 222.0/255.0, blue: 173.0/255.0, alpha: 1.0),
        32:UIColor(red: 255.0/255.0, green: 250.0/255.0, blue: 205.0/255.0, alpha: 1.0),
        64:UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0),
        128:UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 0.0/255.0, alpha: 1.0),
        256:UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0.0/255.0, alpha: 1.0),
        512:UIColor(red: 205.0/255.0, green: 173.0/255.0, blue: 0.0/255.0, alpha: 1.0),
        1024:UIColor(red: 139.0/255.0, green: 105.0/255.0, blue: 20.0/255.0, alpha: 1.0),
        2048:UIColor(red: 205.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0),
        4096:UIColor(red: 0/255.0, green: 205/255.0, blue: 0/255.0, alpha: 1.0)
]
    
    var value:Int = 0
        {
        didSet
        {
            backgroundColor = colorMap[value]
            numberLabel.text="\(value)"
        }
    }
    
    var numberLabel:UILabel
    
    init(pos:CGPoint,width:CGFloat,value:Int)
    {
        numberLabel = UILabel(frame:CGRectMake(0,0,width,width))
        numberLabel.textColor = UIColor.blueColor()
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont(name:"微软雅黑",size:20)
        numberLabel.text = "\(value)"
        super.init(frame:CGRectMake(pos.x,pos.y,width,width))
        addSubview(numberLabel)
        self.value = value
        backgroundColor = colorMap[value]
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
