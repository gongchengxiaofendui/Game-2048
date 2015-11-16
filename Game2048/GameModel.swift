//
//  GameModel.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import Foundation

class Gamemodel
{
    var dimension:Int = 0
    
    var tiles:Array<Int>!
    
    var mtiles:Array<Int>!
    
    var scoredelegate:ScoreViewProtocol!
    
    var bestscoredelegate:ScoreViewProtocol!
    
    var score:Int = 0
    var bestscore:Int = 0
    
    var maxnumber:Int = 0
    
    init(dimension:Int,maxnumber:Int,score:ScoreViewProtocol,bestscore:ScoreViewProtocol)
    {
        self.maxnumber = maxnumber
        self.dimension = dimension
        self.scoredelegate = score
        self.bestscoredelegate = bestscore
        initTiles()
    }
    
    func isSuccess() ->Bool
    {
        for i in 0..<(dimension * dimension)
        {
            if(tiles[i] >= maxnumber)
            {
                return true
            }
        }
        return false
    }
    
    func initTiles()
    {
        self.tiles = Array<Int>(count:self.dimension*self.dimension,repeatedValue:0)
        self.mtiles = Array<Int>(count:self.dimension*self.dimension,repeatedValue:0)
        
        self.score = 0
    }
    
    //如果返回false，表示该位置已经有值
    func setPosition(row:Int,col:Int,value:Int) -> Bool
    {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        
        // 3行4列，row ＝ 2，col ＝ 3 index ＝ 2*4+3 ＝ 11
        // 4行4列，3*4+3 ＝ 15
        let index = self.dimension * row + col
        let val = tiles[index]
        if (val > 0)
        {
            print("该位置已经有值")
            return false
        }
        tiles[index] = value
        return true
    }
    
    func emptyPositions() -> [Int]
    {
        var emptytiles = [Int]()
        
        for i in 0..<(dimension * dimension)
        {
            if(tiles[i] == 0)
            {
                emptytiles.append(i)
            }
        }
        return emptytiles
    }
    
    func isfull() -> Bool
    {
        if(emptyPositions().count == 0)
        {
            return true
        }
        return false
    }
    
    func copyToMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            mtiles[i] = tiles[i]
        }
    }
    
    func copyFromMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            tiles[i] = mtiles[i]
        }
    }
    
    func reflowUp()
    {
        copyToMtiles()
        var index:Int
        for var i = dimension - 1; i > 0; i--
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                if(mtiles[index - self.dimension] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index - self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while(subindex + self.dimension < mtiles.count)
                    {
                        if(mtiles[subindex + self.dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + self.dimension]
                            mtiles[subindex + self.dimension] = 0
                        }
                        subindex += self.dimension
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowDown()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension - 1
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                if(mtiles[index + self.dimension] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index + self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while((subindex - self.dimension) >= 0 )
                    {
                        if(mtiles[subindex - self.dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex - self.dimension]
                            mtiles[subindex - self.dimension] = 0
                        }
                        subindex -= self.dimension
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowLeft()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension
        {
            for var j = dimension - 1; j > 0; j--
            {
                index = self.dimension * i + j
                if(mtiles[index - 1] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index - 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while((subindex + 1) < i * dimension + dimension)
                    {
                        if(mtiles[subindex + 1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + 1]
                            mtiles[subindex + 1] = 0
                        }
                        subindex += 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowRight()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension
        {
            for j in 0..<dimension - 1
            {
                index = self.dimension * i + j
                if(mtiles[index + 1] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index + 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while((subindex - 1) < i * dimension - 1)
                    {
                        if(mtiles[subindex - 1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex - 1]
                            mtiles[subindex - 1] = 0
                        }
                        subindex -= 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func changeScore(s:Int)
    {
        score += s
        if(bestscore < score)
        {
            bestscore = score
        }
        scoredelegate.changeScore(value: score)
        bestscoredelegate.changeScore(value: score)
    }
    
    func mergeUp()
    {
        copyToMtiles()
        var index:Int
        for var i = dimension - 1; i > 0; i--
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                if((mtiles[index] > 0) && (mtiles[index - self.dimension] == mtiles[index]))
                {
                    mtiles[index - self.dimension] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeDown()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension - 1
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                if((mtiles[index] > 0) && (mtiles[index + self.dimension] == mtiles[index]))
                {
                    mtiles[index + self.dimension] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeLeft()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension
        {
            for var j = dimension - 1; j > 0; j--
            {
                index = self.dimension * i + j
                if((mtiles[index] > 0) && (mtiles[index - 1] == mtiles[index]))
                {
                    mtiles[index - 1] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeRight()
    {
        copyToMtiles()
        var index:Int
        for i in 0..<dimension
        {
            for j in 0..<dimension - 1
            {
                index = self.dimension * i + j
                if((mtiles[index] > 0) && (mtiles[index + 1] == mtiles[index]))
                {
                    mtiles[index + 1] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    
    
    
}
