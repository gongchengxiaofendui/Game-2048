//
//  ScoreView.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

protocol ScoreViewProtocol
{
    func changeScore(value s:Int)
}

class ScoreView:UIView, ScoreViewProtocol
{
    var label:UILabel
    var defaultFram = CGRectMake(0, 0, 100, 30)
    var score:Int = 0{
        didSet{
            label.text = "分数:\(score)"
        }
    }
    
    init()
    {
        label = UILabel(frame:defaultFram)
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame:defaultFram)
        
        backgroundColor = UIColor.orangeColor()
        label.font = UIFont(name: "微软雅黑", size: 16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeScore(value s:Int)
    {
        score = s
    }
}

class BestScoreView:ScoreView
{
    var bestscore:Int = 0{
        didSet{
            label.text = "最高分:\(bestscore)"
        }
    }
    
    override func changeScore(value s: Int) {
        bestscore = s
    }
}
