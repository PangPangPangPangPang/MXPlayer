//
//  ViewController.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit

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
        let controller = UIPlayerViewController.init(url: NSURL.init(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"))
        self.presentViewController(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

