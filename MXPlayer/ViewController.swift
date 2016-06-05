//
//  ViewController.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit

let videoUrl = "http://api.sina.cn/sinago/video_location.json?sf_i=4&video_id=250616284-140244581&video_play_url=http%3A%2F%2Fask.ivideo.sina.com.cn%2Fv_play_ipad.php%3Fvid%3D140244581&tags=newsapp_iPhone&fromsinago=1&postt=news_news_news_10&from=6051093012"
let appleVideoUrl = "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
let localVideoUrl: String! = NSBundle.mainBundle().pathForResource("MIMK-042", ofType: "avi")
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button: UIButton = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.blueColor()
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(ViewController.action), forControlEvents: .TouchUpInside)
    }
    
    func action() {
        let controller = UIPlayerViewController.init(url: NSURL.init(
            string: appleVideoUrl))
        controller.willMoveToParentViewController(self)
        controller.originFrame = CGRectMake(0, 0, self.view.frame.size.width, 300)
        self.view.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

