//
//  MainViewController.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

enum Animation2048Type
{
    case None  //无动画
    case New   //新数动画
    case Merge  //合并动画
}

class MainViewController:UIViewController{
    var dimension:Int = 4
        {
        didSet{
            gmodel.dimension = dimension
        }
    }//游戏方格维度
    var maxnumber:Int = 2048
        {
        didSet{
            gmodel.maxnumber = maxnumber
        }
    }//游戏过关最大值
    var width:CGFloat = 50 //数字格子的宽度
    var padding:CGFloat = 6 //格子之间的间距
    var backgrounds:Array<UIView>//保存背景图数据
    var gmodel:Gamemodel! //游戏数据模型
    var tiles:Dictionary<NSIndexPath,TileView> //保存界面上的Label数据
    var tileVals:Dictionary<NSIndexPath,Int>   //保存实际数字值
    
    var score:ScoreView!
    var bestscore:BestScoreView!
    
    init()
    {
        self.backgrounds = Array<UIView>()
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        
        super.init(nibName:nil,bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBackground()
        setupButtons()
        setupSwipeGuestures()
        setupScoreLabels()
        self.gmodel = Gamemodel(dimension: self.dimension,maxnumber:maxnumber,score:score,bestscore:bestscore)
        for _ in 0..<2
        {
            genNumber()
        }
    }
    
    func setupButtons()
    {
        let cv = ControlView()
        let btnreset = cv.createButton("重置", action: Selector("resetTapped"), sender: self)
        btnreset.frame.origin.x = 50
        btnreset.frame.origin.y = 450
        self.view.addSubview(btnreset)
        
        let btngen = cv.createButton("新数", action: Selector("genTapped"), sender: self)
        btngen.frame.origin.x = 170
        btngen.frame.origin.y = 450
        self.view.addSubview(btngen)
    }
    
    func setupScoreLabels()
    {
        score = ScoreView()
        score.frame.origin.x = 50
        score.frame.origin.y = 80
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = BestScoreView()
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
    }
    
    func genTapped()
    {
        print("gen")
        genNumber()
    }
    func resetTapped()
    {
        print("reset")
        resetUI()
        gmodel.initTiles()
        genNumber()
        genNumber()
    }
    
    func initUI()
    {
        var index:Int
        var key:NSIndexPath
        var tile:TileView
        var tileVal:Int
        
        var success = false
        
        for i in 0..<dimension
        {
            for j in 0..<dimension
            {
                index = i * self.dimension + j
                key  = NSIndexPath(forRow: i, inSection: j)
                
                
                if(gmodel.tiles[index] >= maxnumber)
                {
                    success = true
                }
                
                //原来界面没有值，模型数据中有值
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) == nil))
                {
                    insertTile((i,j), value: gmodel.mtiles[index], atype:Animation2048Type.Merge)
                }
                
                //原来有值，现在模型中没有值
                if((gmodel.tiles[index] == 0) && (tileVals.indexForKey(key) != nil))
                {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                }
                
                //原来有值，现在还是有值
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) != nil))
                {
                    tileVal = tileVals[key]!
                    if(tileVal != gmodel.tiles[index])
                    {
                        tile = tiles[key]!
                        tile.removeFromSuperview()
                        
                        tiles.removeValueForKey(key)
                        tileVals.removeValueForKey(key)
                        insertTile((i,j), value: gmodel.tiles[index], atype:Animation2048Type.Merge)
                    }
                }
                /* if(gmodel.tiles[index] != 0)
                {
                insertTile((i,j), value: gmodel.mtiles[index])
                }
                */
            }
        }
        if(gmodel.isSuccess())
        {
            
            let alertView = UIAlertView()
            alertView.title = "恭喜"
            alertView.message = "您已通关！"
            alertView.addButtonWithTitle("确定")
            alertView.show()
            return
        }
    }
    
    func resetUI()
    {
        for(_,tile) in tiles
        {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity: true)
        tileVals.removeAll(keepCapacity: true)
        for background in backgrounds
        {
            background.removeFromSuperview()
        }
        
        setupBackground()
        
        score.changeScore(value: 0)
        
        
    }
    
    func removeKeyTile(key:NSIndexPath)
    {
        let tile = tiles[key]!
        _ = tileVals[key]
        
        tile.removeFromSuperview()
        tiles.removeValueForKey(key)
        tileVals.removeValueForKey(key)
    }
    
    func setupBackground()
    {
        var x:CGFloat = 30
        var y:CGFloat = 150
        
        for _ in 0..<dimension
        {
            y = 150
            for _ in 0..<dimension
            {
                let background = UIView(frame:CGRectMake(x,y,width,width))
                background.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(background)
                backgrounds += [background]
                y += padding + width
            }
            x += padding + width
        }
    }
    
    func setupSwipeGuestures()
    {
        let upSwipe = UISwipeGestureRecognizer(target:self, action: Selector("swipeUp"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target:self, action: Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target:self, action: Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target:self, action: Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func printTiles(tiles:Array<Int>)
    {
        let count = tiles.count
        for var i = 0; i < count; i++
        {
            if(i + 1) % Int(dimension) == 0
            {
                print("\(tiles[i])\n")
            }
            else
            {
                print("\(tiles[i])\t")
            }
        }
    }
    
    func swipeUp()
    {
        print("swipeup")
        
        gmodel.reflowUp()
        gmodel.mergeUp()
        gmodel.reflowUp()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        // resetUI()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
        /*
        for i in 0..<dimension
        {
        for j in 0..<dimension
        {
        var row:Int = i
        var col:Int = j
        var key = NSIndexPath(forRow: row, inSection: col)
        if(tileVals.indexForKey(key) != nil)
        {
        //if  row>3 move up one line
        if(row > 0)
        {
        var value = tileVals[key]
        removeKeyTile(key)
        var index = row * dimension + col - dimension
        row = Int(index / dimension)
        col = index - row * dimension
        insertTile((row,col), value:value!)
        }
        }
        }
        }
        */
    }
    
    func swipeDown()
    {
        print("swipedown")
        gmodel.reflowDown()
        gmodel.mergeDown()
        gmodel.reflowDown()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        // resetUI()
        initUI()
        
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }
    
    func swipeLeft()
    {
        print("swipeleft")
        gmodel.reflowLeft()
        gmodel.mergeLeft()
        gmodel.reflowLeft()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        // resetUI()
        initUI()
        
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }
    
    func swipeRight()
    {
        print("swiperight")
        gmodel.reflowRight()
        gmodel.mergeRight()
        gmodel.reflowRight()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        //  resetUI()
        initUI()
        
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }
    
    func genNumber()
    {
        let randv = Int(arc4random_uniform(10))
        print(randv)
        var seed:Int = 2
        if(randv == 1)
        {
            seed = 4
        }
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        
        if(gmodel.isfull())
        {
            print("位置已经满了")
            let alertView = UIAlertView()
            alertView.title = "Game Over!"
            alertView.message = "Game Over！"
            alertView.addButtonWithTitle("确定")
            alertView.show()
            return
        }
        if(gmodel.setPosition(row, col: col, value: seed) == false)
        {
            genNumber()
            return
        }
        
        insertTile((row,col),value:seed,atype:Animation2048Type.New)
    }
    
    func insertTile(pos:(Int,Int),value:Int,atype:Animation2048Type)
    {
        let (row,col)=pos;
        
        let x = 30 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos:CGPointMake(x,y),width:width,value:value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        
        let index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        
        if(atype == Animation2048Type.None)
        {
            return
        }
        else if(atype == Animation2048Type.New)
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.05, 0.05))
        }
        else if(atype == Animation2048Type.Merge)
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        }
        
        tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.05, 0.05))
        
        UIView.animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations:
            {
                () -> Void in
                tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
            }, completion:
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.08, animations: {
                    () -> Void in
                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
    }
}
