//
//  MXPlayerViewController.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

class MXPlayerViewController: UIViewController,MXPlayerCallBack, MXPlayerProtocol {
    var url: NSURL?
    var player: MXPlayer!
    var playerView: MXPlayerView!
    var currentTime: NSTimeInterval! = 0
    var duration: NSTimeInterval! = 0
    var playableDuration: NSTimeInterval! = 0
    var bufferingProgress: Int64! = 0
    var isReady: Bool! = false
    var movieState: MXPlayerMovieState! = .stopped
    var loadState: MXPlayerLoadState! = .unknown
    var bufferState: MXPlayerBufferState! = .unknown
    var numberOfBytesTransferred: Int64! = 0
    var naturalSize: CGSize! = CGSize.init(width: 10, height: 10)
    var scalingMode: MXPlayerScaleMode! = .aspectFit
    var shouldAutoPlay: Bool! = false
    var allowsMediaAirPlay :Bool! = false
    var isDanmakuMediaAirPlay: Bool! = false
    var airPlayMediaActive: Bool! = false
    var playbackRate: Float! = 0

    init(url: NSURL?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
        AudioSessionManager.shareInstance.audioSession()
        self.prepareToplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        let btn = UIButton()
        btn.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        btn.backgroundColor = UIColor.purpleColor()
        btn.addTarget(self, action: #selector(MXPlayerViewController.onTapStart), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
    }
    func onTapStart() -> Void {
        self.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MXPlayerViewController {
    func playerObserver(item: AVPlayerItem?, keyPath: String?, change: [String : AnyObject]?) {
        switch keyPath! {
        case "status":
            do {
                let status = change![NSKeyValueChangeNewKey] as! Int
                switch status {
                case AVPlayerItemStatus.ReadyToPlay.rawValue:
                    loadState = .playable
                    duration = player.duration
                    break
                case AVPlayerItemStatus.Failed.rawValue:
                    loadState = .failed
                    break
                default:
                    break
                }
                
            }
            break
        case "loadedTimeRanges":
            do {
                playableDuration = player.availableDuration()
                }
            break
        case "playbackBufferFull":
            do {
                bufferState = .full
                }
            break
        case "playbackLikelyToKeepUp":
            do {
                bufferState = .keepUp
            }
            break
        case "playbackBufferEmpty":
            do {
                bufferState = .empty
            }
            break;

        default:
            break
        }
    }
}

extension MXPlayerViewController {
    func prepareToplay() -> Void {
        let item = AVPlayerItem.init(URL: url!);
        player = MXPlayer.init(item: item, delegate: self)
        playerView = MXPlayerView.init(player: player, frame: UIScreen.mainScreen().bounds);
        playerView.userInteractionEnabled = false
        self.view.addSubview(playerView)
    }
    func play() -> Void {
        player.play()
        player.prerollAtRate(0.5) { (result) in
            print("result:\(result)")
        }
    }
    func pause() -> Void {
        player.pause()
    }
    func stop() -> Void {
        
    }
    func isPlayer() -> Bool {
        return true
    }
    func shutDown() -> Void {
        
    }
    func flashImage() -> UIImage {
        return UIImage()
    }
    
    func seekToTime(time: NSTimeInterval) -> Void {
        player.seekToTime(CMTimeMakeWithSeconds(time, 1), toleranceBefore: CMTimeMakeWithSeconds(0.2, 1), toleranceAfter: CMTimeMakeWithSeconds(0.2, 1)) { (result) in
            print(result)
        }
    }
}
