//
//  MainTabViewController.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

class MainTabViewController:UITabBarController{
    init()
    {
        super.init(nibName:nil,bundle:nil)
        
        let viewMain = MainViewController()
        viewMain.title = "2048"
        let viewSetting = SettingViewController(mainveiw: viewMain)
        viewSetting.title = "设置"
        let main = UINavigationController(rootViewController:viewMain)
        let setting = UINavigationController(rootViewController:viewSetting)
        self.viewControllers = [
            main,setting
        ]
        self.selectedIndex = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

