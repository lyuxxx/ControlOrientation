//
//  SecondViewController.swift
//  ControlOrientation
//
//  Created by 刘雨轩 on 2017/7/18.
//  Copyright © 2017年 联通智网. All rights reserved.
//

import UIKit
import SnapKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

class SecondViewController: UIViewController {
    
    var statusBarHidden: Bool = false

    lazy var videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("退出", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        return btn
    }()

    lazy var fullBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("full", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(fullScreen(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
//        edgesForExtendedLayout = []
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        videoView.addGestureRecognizer(tap)

        view.addSubview(videoView)
        videoView.addSubview(backBtn)
        videoView.addSubview(fullBtn)

        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(screenWidth * screenWidth / screenHeight)//使videoView宽高比为屏幕高宽比
        }

        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(videoView.safeAreaLayoutGuide.snp.left)
        }

        fullBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(videoView.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(videoView.safeAreaLayoutGuide.snp.right)
        }
        
    }

    /// 横竖屏切换回调
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let isLandscape = size.width > size.height

        /// 切换回竖屏时把所有元素显示,iPhoneX横屏不显示状态栏,会导致按钮隐藏和状态栏隐藏不同步
        if !isLandscape {
            statusBarHidden = false
            setNeedsStatusBarAppearanceUpdate()
            backBtn.isHidden = false
            fullBtn.isHidden = false
        }

        if isLandscape {
            videoView.snp.updateConstraints { (make) in
                make.height.equalTo(screenWidth)
            }
        } else {
            videoView.snp.updateConstraints { (make) in
                make.height.equalTo(screenWidth * screenWidth / screenHeight)
            }
        }
    }
    
    func didTap(_ sender: UITapGestureRecognizer) {
        let hidden = UIApplication.shared.isStatusBarHidden
        statusBarHidden = !hidden
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
            if !self.backBtn.isHidden {
                self.backBtn.isHidden = true
                self.fullBtn.isHidden = true
            } else {
                self.backBtn.isHidden = false
                self.fullBtn.isHidden = false
            }
        }

    }

    @objc
    func fullScreen(_ sender: UIButton) {
        full()
    }

    @objc
    func dismiss(_ sender: UIButton) {
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
        return .fade
    }

}
