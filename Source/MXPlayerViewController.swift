//
//  MXPlayerViewController.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

typealias MXPlayerViewSubClazzImp = MXPlayerViewController

class MXPlayerViewController: UIViewController,MXPlayerCallBack, MXPlayerProtocol,MXPlayerSubClazzProtocol {
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
    var numberOfBytesTransferred: Int64! = 0
    var naturalSize: CGSize! = CGSize.init(width: 10, height: 10)
    var scalingMode: MXPlayerScaleMode! = .aspectFit
    var shouldAutoPlay: Bool! = false
    var allowsMediaAirPlay :Bool! = false
    var isDanmakuMediaAirPlay: Bool! = false
    var airPlayMediaActive: Bool! = false
    var playbackRate: Float! = 0
    var bufferState: MXPlayerBufferState! {
        get {
            return self.bufferState
        }
        set {
            switch newValue as MXPlayerBufferState {
            case .unknown:
                break
            case .empty:
                break
            case .keepUp:
                break
            case .full:
                break
            }
            print(newValue)
        }
    }
    
    init(url: NSURL?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
        bufferState = .unknown
        AudioSessionManager.shareInstance.audioSession()
        self.prepareToplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                self.playableDurationDidChange()
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
        movieState = .playing
    }
    func pause() -> Void {
        player.pause()
        movieState = .paused
    }
    func stop() -> Void {
        
    }
    func isPlayer() -> Bool {
        return movieState == MXPlayerMovieState.playing
    }
    func shutDown() -> Void {
        
    }
    func flashImage() -> UIImage {
        return UIImage()
    }
    
    func seekToTime(time: NSTimeInterval) -> Void {
        player.seekToTime(CMTimeMakeWithSeconds(time, Int32(kCMTimeMaxTimescale)),
                          toleranceBefore: CMTimeMakeWithSeconds(0.2, Int32(kCMTimeMaxTimescale)),
                          toleranceAfter: CMTimeMakeWithSeconds(0.2, Int32(kCMTimeMaxTimescale))) {
                            (result) in
                            print(result)
        }
    }
    
}
extension MXPlayerViewSubClazzImp {
    func playableDurationDidChange() {}
}
