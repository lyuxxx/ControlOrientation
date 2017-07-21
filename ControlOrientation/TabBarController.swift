//
//  TabBarController.swift
//  ControlOrientation
//
//  Created by 刘雨轩 on 2017/7/18.
//  Copyright © 2017年 联通智网. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        if let naVC : NavigationController = selectedViewController as? NavigationController {
            return naVC.shouldAutorotate
        }
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let naVC : NavigationController = selectedViewController as? NavigationController {
            return naVC.supportedInterfaceOrientations
        }
        return [.all]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
