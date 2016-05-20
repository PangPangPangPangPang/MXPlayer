//
//  MXPlayerViewController.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

class MXPlayerViewController: UIViewController,MXPlayerDelegate {
    var url: NSURL?
    
    init(url: NSURL?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        let item = AVPlayerItem.init(URL: url!);
        let player = MXPlayer.init(item: item, delegate: self)
        let playerView = MXPlayerView.init(player: player, frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 300));
        self.view.addSubview(playerView)
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MXPlayerViewController {
    func playerObserver(item: AVPlayerItem?, keyPath: String?, change: [String : AnyObject]?) {
        print("\(keyPath),\(change)")
    }
}

