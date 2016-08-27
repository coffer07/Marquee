//
//  MarqueeView.swift
//  Marquee
//
//  Created by 高翔 on 16/8/26.
//  Copyright © 2016年 高翔. All rights reserved.
//

import UIKit

// 设置文字长度大于MarqueeView的长度会自动向左滚动

class MarqueeView: UIView {
    /// 前后间距
    private let xMargin: CGFloat = 80
    /// 时间
    private var time: Double = 10
    private var isRun: Bool = false
    private var isSuspend: Bool = false
    
    private let frontLabel = UILabel()
    private let behindLabel = UILabel()
    
    var font = UIFont.systemFontOfSize(14) {
        didSet {
            frontLabel.font = font
            behindLabel.font = font
        }
    }
    
    var color = UIColor.blackColor() {
        didSet {
            frontLabel.textColor = color
            behindLabel.textColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        frontLabel.font = font
        behindLabel.font = font
        
        frontLabel.textColor = color
        behindLabel.textColor = color
        
        self.addSubview(frontLabel)
        self.addSubview(behindLabel)
        
    }
    
    // MARK: - 开始跑马灯动画
    func start(){
        if isRun == false {
            isRun = true
            isSuspend = false
            frontLabel.layer.timeOffset = 0.0
            behindLabel.layer.timeOffset = 0.0
            frontLabel.layer.speed = 1.0
            behindLabel.layer.speed = 1.0
            frontLabel.layer.beginTime = 0.0
            behindLabel.layer.beginTime = 0.0
            marqueeAnimation()
        }
    }
    
    // MARK: - 停止跑马灯动画
    func stop() {
        if isRun {
            isRun = false
            frontLabel.layer.removeAnimationForKey("frontAnima")
            behindLabel.layer.removeAnimationForKey("behindAnima")
        }
    }
    
    // MARK: -  暂停动画
    func suspend() {
        if isRun && isSuspend == false {
            isSuspend = true
            
            let frontPauseTime = frontLabel.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
            frontLabel.layer.speed = 0.0
            frontLabel.layer.timeOffset = frontPauseTime

            let behindPauseTime = behindLabel.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
            behindLabel.layer.speed = 0.0
            behindLabel.layer.timeOffset = behindPauseTime
            
        }
    }
    
    // MARK: - 继续动画
    func continuation() {
        if isRun && isSuspend {
            isSuspend = false
            let frontPauseTime = frontLabel.layer.timeOffset
            frontLabel.layer.speed = 1.0
            frontLabel.layer.timeOffset = 0.0
            frontLabel.layer.beginTime = 0.0
            let frontTimeSincePause = frontLabel.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)  - frontPauseTime
            frontLabel.layer.beginTime = frontTimeSincePause
            
            let behindPauseTime = behindLabel.layer.timeOffset
            behindLabel.layer.speed = 1.0
            behindLabel.layer.timeOffset = 0.0
            behindLabel.layer.beginTime = 0.0
            let behindTimeSincePause = behindLabel.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)  - behindPauseTime
            behindLabel.layer.beginTime = behindTimeSincePause
            
        }
    }
    
    // MARK: - 设置显示文字
    func setTitle(title: String) {
        self.stop()
        
        frontLabel.text = title
        frontLabel.sizeToFit()
        frontLabel.frame.size.width = frontLabel.frame.width + xMargin
        frontLabel.center.y = self.frame.height / 2
        frontLabel.frame.origin.x = 0
        
        behindLabel.text = title
        behindLabel.sizeToFit()
        behindLabel.frame.size.width = frontLabel.frame.width
        behindLabel.frame.origin.x = CGRectGetMaxX(frontLabel.frame)
        behindLabel.center.y = self.frame.height / 2
        
        if behindLabel.frame.width > self.frame.width {
            behindLabel.hidden = false
            self.start()
        }
        else {
            behindLabel.hidden = true
        }
    }
    
    // MARK: - 跑马灯动画实现过程
    func marqueeAnimation() {
        let frontAnima = CABasicAnimation()
        frontAnima.keyPath = "position"
        frontAnima.fromValue = NSValue(CGPoint: CGPoint(x:  self.frontLabel.frame.width / 2 , y: self.frame.height / 2))
        frontAnima.toValue = NSValue(CGPoint: CGPoint(x: -1 * self.frontLabel.frame.width / 2, y: self.frame.height / 2))
        frontAnima.duration = self.time
        frontAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        frontAnima.repeatCount = MAXFLOAT
        
        let behindAnima = CABasicAnimation()
        behindAnima.keyPath = "position"
        behindAnima.fromValue = NSValue(CGPoint: CGPoint(x:  self.frontLabel.frame.width / 2 * 3 , y: self.frame.height / 2))
        behindAnima.toValue = NSValue(CGPoint: CGPoint(x:  self.frontLabel.frame.width / 2, y: self.frame.height / 2))
        behindAnima.duration = self.time
        behindAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        behindAnima.repeatCount = MAXFLOAT
        
        self.frontLabel.layer.addAnimation(frontAnima, forKey: "frontAnima")
        self.behindLabel.layer.addAnimation(behindAnima, forKey: "behindAnima")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Marquee - deinit")
    }

}
