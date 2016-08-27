//
//  ViewController.swift
//  Marquee
//
//  Created by 高翔 on 16/8/26.
//  Copyright © 2016年 高翔. All rights reserved.
//

import UIKit

let ScreenHeight = UIScreen.mainScreen().bounds.height
let ScreenWidth = UIScreen.mainScreen().bounds.width

class ViewController: UIViewController {

    private let marqueeLabel = MarqueeView(frame: CGRect(x: 16 , y: 200 , width: ScreenWidth - 32, height: 36))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "跑马灯"
        
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSize(width: ScreenWidth, height: ScreenHeight + 200)
        self.view.addSubview(scrollView)
        
        marqueeLabel.setTitle("swift语言是世界上最好的语言!  好吧，字数不够长来凑字数")
        scrollView.addSubview(marqueeLabel)
        
        let startBtn = UIButton()
        startBtn.frame = CGRect(x: 16, y: ScreenHeight - 50, width: (ScreenWidth - 32) / 4, height: 40)
        startBtn.setTitle("开始", forState: .Normal)
        startBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        startBtn.addTarget(self, action: #selector(start(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(startBtn)
        
        let stopBtn = UIButton()
        stopBtn.frame = CGRect(x: 16 + (ScreenWidth - 32) / 4, y: ScreenHeight - 50, width: (ScreenWidth - 32) / 4, height: 40)
        stopBtn.setTitle("停止", forState: .Normal)
        stopBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        stopBtn.addTarget(self, action: #selector(stop(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(stopBtn)
        
        let suspendBtn = UIButton()
        suspendBtn.frame = CGRect(x: 16 + (ScreenWidth - 32) / 2, y: ScreenHeight - 50, width: (ScreenWidth - 32) / 4, height: 40)
        suspendBtn.setTitle("暂停", forState: .Normal)
        suspendBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        suspendBtn.addTarget(self, action: #selector(suspend(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(suspendBtn)
        
        let continuationBtn = UIButton()
        continuationBtn.frame = CGRect(x: 16 + (ScreenWidth - 32) / 4 * 3, y: ScreenHeight - 50, width: (ScreenWidth - 32) / 4, height: 40)
        continuationBtn.setTitle("继续", forState: .Normal)
        continuationBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        continuationBtn.addTarget(self, action: #selector(continuation(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(continuationBtn)
       
    }
    
    // MARK: - 开始跑马灯动画
    func start(send: UIButton){
        marqueeLabel.start()
    }
    
    // MARK: - 停止跑马灯动画
    func stop(send: UIButton) {
        marqueeLabel.stop()
    }
    
    // MARK: -  暂停动画
    func suspend(send: UIButton) {
        marqueeLabel.suspend()
    }
    
    // MARK: - 继续动画
    func continuation(send: UIButton) {
        marqueeLabel.continuation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("ViewController - deinit")
    }

}

