//
//  SecondViewController.swift
//  ControlOrientation
//
//  Created by 刘雨轩 on 2017/7/18.
//  Copyright © 2017年 联通智网. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var statusBarHidden : Bool = false

    @IBOutlet weak var videoView: UIView!//宽高比为屏幕高宽比，autolayout自动处理，感觉代码写比较好？
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
//        edgesForExtendedLayout = []
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        videoView.addGestureRecognizer(tap)
        
    }
    
    func didTap(_ sender: UITapGestureRecognizer) {
        let hidden = UIApplication.shared.isStatusBarHidden
        statusBarHidden = !hidden
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @IBAction func fullScreen(_ sender: UIButton) {
        full()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        let orientation = UIApplication.shared.statusBarOrientation
        print(orientation.rawValue)
        if orientation.isLandscape {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        } else {
            navigationController?.popViewController(animated: true)
            //        dismiss(animated: true, completion: nil)
        }
    }
    
    func full() {
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isLandscape {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        } else {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        }
    }
    
    // MARK: - orientation
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.all]
    }
    
    // MARK: - status bar
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    //动画类型，动画需要自己实现?
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
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
