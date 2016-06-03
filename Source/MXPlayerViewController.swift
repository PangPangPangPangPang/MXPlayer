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
    var loadState: MXPlayerLoadState! = .unknown
    var naturalSize: CGSize! = CGSize.init(width: 10, height: 10)
    var scalingMode: MXPlayerScaleMode! = .aspectFit
    var shouldAutoPlay: Bool! = false
    var allowsMediaAirPlay :Bool! = false
    var isDanmakuMediaAirPlay: Bool! = false
    var airPlayMediaActive: Bool! = false
    var playbackRate: Float! = 0
    var bufferState: MXPlayerBufferState! {
        didSet {
            switch bufferState as MXPlayerBufferState {
            case .unknown:
                break
            case .empty:
                self.playableBufferBecomeEmpty()
                break
            case .keepUp:
                self.playableBufferBecomeKeepUp()
                break
            case .full:
                break
            }
            print("bufferState:\(bufferState)")
        }
    }
    
    var movieState: MXPlayerMovieState! {
        didSet {
            print(movieState)
        }
    }
    
    var canPlayFastForward: Bool? {
        get {
            return self.player.currentItem?.canPlayFastForward
        }
    }

    var canPlaySlowForward: Bool? {
        get {
            return self.player.currentItem?.canPlaySlowForward
        }
    }
    
    var canPlayFastReverse: Bool? {
        get {
            return self.player.currentItem?.canPlayFastReverse
        }
    }
    
    var canPlaySlowReverse: Bool? {
        get {
            return self.player.currentItem?.canPlaySlowReverse
        }
    }
    
    init(url: NSURL?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
        bufferState = .unknown
        movieState = .stopped
        AudioSessionManager.shareInstance.audioSession()
        self.prepareToplay(self.url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                loadState = .playable
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
    
    func playerPlayWithTime(time: CMTime) {
        guard duration != 0 else {return}

        currentTime = CMTimeGetSeconds(time)
        playbackRate = Float(currentTime) / Float(duration)
        self.playDurationDidChange(playbackRate, second: currentTime)
    }

}

extension MXPlayerViewController {
    func prepareToplay(url: NSURL?) -> Void {
        let item = AVPlayerItem.init(URL: url ?? self.url!);
        if player == nil {
            player = MXPlayer.init(item: item, delegate: self)
            playerView = MXPlayerView.init(player: player, frame: UIScreen.mainScreen().bounds);
            playerView.userInteractionEnabled = false
            self.view.addSubview(playerView)
        } else {
            self.pause()
            player.changePlayerItem(item)
            self.play()
        }
    }
    func play() -> Void {
        if loadState == MXPlayerLoadState.playable
        && movieState != MXPlayerMovieState.playing {
            player.play()
            movieState = .playing
        }
    }
    func pause() -> Void {
        player.pause()
        movieState = .paused
    }
    func stop() -> Void {
        player.setRate(0, time: kCMTimeInvalid, atHostTime: kCMTimeInvalid)
        movieState = .stopped
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
    func playDurationDidChange(rate: Float, second: NSTimeInterval) {}
    func playableBufferBecomeEmpty() {}
    func playableBufferBecomeKeepUp() {}

}
