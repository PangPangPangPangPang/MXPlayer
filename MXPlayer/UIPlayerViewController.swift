//
//  UIPlayerViewController.swift
//  MXPlayer
//
//  Created by Max Wang on 16/6/3.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import Foundation
import UIKit

class UIPlayerViewController: MXPlayerViewController {
    
    let availableProgressView: UIView!
    let textField: UITextField!
    let label: UILabel!
    let current: UIView!
    
    override init(url: NSURL?) {
        availableProgressView = UIView.init(frame: CGRect.init(x: 0, y: 60, width: 0, height: 20))
        current = UIView.init(frame: CGRect.init(x: 0, y: 65, width: 10, height: 10))

        textField = UITextField.init(frame: CGRect.init(x: 20, y: 100, width: 200, height: 50))
        label = UILabel()
        super.init(url: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let btn = UIButton.init(type: .Custom)
        btn.setTitle("start", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.frame = CGRect.init(x: 0, y: 20, width: 50, height: 50)
        btn.addTarget(self, action: #selector(UIPlayerViewController.onTapStart), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        
        let pausebtn = UIButton.init(type: .Custom)
        pausebtn.setTitle("pause", forState: .Normal)
        pausebtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        pausebtn.frame = CGRect.init(x: 100, y: 20, width: 50, height: 50)
        pausebtn.addTarget(self, action: #selector(UIPlayerViewController.onTapPause), forControlEvents: .TouchUpInside)
        self.view.addSubview(pausebtn)

        
        textField.layer.cornerRadius = 1
        textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        textField.placeholder = "  input number < 1"
        textField.layer.borderColor = UIColor.blackColor().CGColor
        textField.layer.borderWidth = 0.5
        self.view.addSubview(textField)
        
        let progressView = UIView.init(frame: CGRect.init(x: 0, y: 60, width: self.view.frame.size.width, height: 20))
        progressView.backgroundColor = UIColor.blueColor()
        progressView.alpha = 0.5
        self.view.addSubview(progressView)
        
        availableProgressView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(availableProgressView)
        
        current.backgroundColor = UIColor.greenColor()
        current.alpha = 0.5
        self.view.addSubview(current)
        
        let btn1 = UIButton.init(type: .Custom)
        btn1.setTitle("confirm", forState: .Normal)
        btn1.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn1.frame = CGRect.init(x: 240, y: 100, width: 80, height: 50)
        btn1.addTarget(self, action: #selector(UIPlayerViewController.confirm), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn1)
        
        label.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 100, width: self.view.frame.size.width, height: 50)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        self.view.addSubview(label)
    }
}

extension UIPlayerViewController {
    func onTapStart() -> Void {
        self.play()
    }
    
    func confirm() {
        //        self.prepareToplay(NSURL.init(string: videoUrl))
        //        return
        textField.resignFirstResponder()
        let t = NSTimeInterval(textField.text!) ?? 0
        self.seekToTime(t * player.duration)
    }

    func onTapPause() -> Void {
        self.pause()
    }
}

extension UIPlayerViewController {
    override func playableDurationDidChange() {
        availableProgressView.frame = CGRect.init(x: 0, y: 60, width: self.view.frame.size.width * CGFloat(player.availableProgress()), height: 20)
    }
    
    override func playDurationDidChange(rate: Float, second: NSTimeInterval) {
        
        current.frame = CGRect.init(x: self.view.frame.size.width * CGFloat(rate), y: 65, width: 10, height: 10)
    }

    
    override func playableBufferBecomeEmpty() {
        label.text = "Loading..."
    }
    
    override func playableBufferBecomeKeepUp() {
        label.text = "playable"
    }

}
