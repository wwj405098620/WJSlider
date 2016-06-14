//
//  WJSlider.swift
//  WJSlider
//
//  Created by 王文杰 on 16/6/13.
//  Copyright © 2016年 王文杰. All rights reserved.
//

import UIKit
private var WJAssociationKey_LeftController: UInt8 = 0

protocol WJSlider{}

protocol WJLeftSlider : WJSlider{
    /*
     * 打开左边栏
     */
    func openLeftSliderController()
    
    /*
     * 关闭左边栏
     */
    func closeLeftSliderController()
}


extension UIViewController{
    
    /*
     * 处理侧滑手势,打开/关闭侧边栏
     */
    func wj_swipe(sender : AnyObject) {
        if let leftSlider = self as? WJLeftSlider{
            if let gesture = sender as? UISwipeGestureRecognizer{
                if gesture.direction ==  .Left{
                    leftSlider.closeLeftSliderController()
                }
                if gesture.direction ==  .Right{
                    if gesture.locationInView(self.view).x < 20 {
                        leftSlider.openLeftSliderController()
                    }
                    
                }
            }
        }
        
    }

}


extension WJLeftSlider where Self:UIViewController{

    /*
     * 存取侧边栏Controller
     */
    private var leftController : UIViewController? {
        get{
            return objc_getAssociatedObject(self, &WJAssociationKey_LeftController) as? UIViewController
        }
        set {
            objc_setAssociatedObject(self, &WJAssociationKey_LeftController, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /*
     * 设置侧边栏
     */
    mutating func setUpLeftSlider(left:UIViewController) {
        self.leftController = left
        let swipe = UISwipeGestureRecognizer(target: self, action:#selector(UIViewController.wj_swipe))
        swipe.direction = .Left
        self.view.addGestureRecognizer(swipe)
        
        let swipe1 = UISwipeGestureRecognizer(target: self, action:#selector(UIViewController.wj_swipe))
        swipe1.direction = .Right
        self.view.addGestureRecognizer(swipe1)
    }

    /*
     * 打开侧边栏
     */
    func openLeftSliderController() {
        self.addChildViewController(leftController!)
        self.view.addSubview(leftController!.view)
        leftController?.view.frame = CGRectMake(-self.view.bounds.width / 2, 0, self.view.bounds.width / 2, self.view.bounds.height)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.leftController?.view.frame = CGRectMake(0, 0, self.view.bounds.width / 2, self.view.bounds.height)
        }) { (_) in
        }
    }
    
    /*
     * 关闭侧边栏
     */
    func closeLeftSliderController() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.leftController?.view.frame.origin = CGPointMake(-(self.view.frame.width)/2, 0)
        }) { (_) in
            self.leftController?.view.removeFromSuperview()
            self.leftController?.removeFromParentViewController()
        }
        
    }
}
