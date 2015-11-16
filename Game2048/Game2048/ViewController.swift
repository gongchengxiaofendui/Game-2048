//
//  ViewController.swift
//  Game2048
//
//  Created by Lancelot on 15/11/13.
//  Copyright © 2015年 Lancelot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startGame(sender: UIButton) {
        let alertView = UIAlertView()
        alertView.title = "开始!"
        alertView.message = "你准备好了吗?"
        alertView.addButtonWithTitle("Ready go!")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView:UIAlertView,clickedButtonAtIndex buttonIndex:Int){
        self.presentViewController(MainTabViewController(),animated:true,completion:nil)
    }

}

