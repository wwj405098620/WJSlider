//
//  ViewController.swift
//  WJSlider
//
//  Created by WenJie on 16/6/13.
//  Copyright © 2016年 WenJie. All rights reserved.
//

import UIKit



class BaseNavigationController: UINavigationController,WJLeftSlider{

}

class ViewController: UIViewController{
    @IBAction func openLeft(sender: AnyObject) {
        let nav = self.navigationController as! BaseNavigationController
        nav.openLeftSliderController()
    }
    @IBAction func closeLeft(sender: AnyObject) {
        let nav = self.navigationController as! BaseNavigationController
        nav.closeLeftSliderController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        let leftController = LeftViewController()
        var nav = self.navigationController as! BaseNavigationController
        nav.setUpLeftSlider(leftController)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



