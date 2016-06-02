//
//  MXPlayer.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

class MXPlayer: AVPlayer {
    var delegate: MXPlayerCallBack?
    var currentTime: Double! = 0
    var duration: Double! {
        set {
            self.duration = newValue
        }
        get {
            var cmtime = kCMTimeInvalid
            if self.status == .ReadyToPlay {
                cmtime = (self.currentItem?.duration)!
            }
            
            let durationTime = CMTimeGetSeconds(cmtime)
            return isnan(durationTime) ? 0:Double(durationTime)
        }
    }
    var progress: Double! = 0
    
    override init() {
        super.init()
    }
    
    init(item: AVPlayerItem, delegate: MXPlayerCallBack) {
        super.init(playerItem: item)
        self.delegate = delegate
        self.addObserver()
        self.addItemObserver()
    }
    func addNoti() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MXPlayer.playToEndNoti(_:)), name: AVPlayerItemDidPlayToEndTimeNotification, object: self.currentItem)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MXPlayer.addObserver), name: AVPlayerItemFailedToPlayToEndTimeNotification, object: self.currentItem)
    }
    
    func playToEndNoti(noti: NSNotification) -> Void {
        delegate?.playerDidEndWithNoti(noti)
    }
    
    func faildePlayToEndNoti(noti: NSNotification) -> Void {
        delegate?.playerFailedDidEndWithNoti(noti)
    }
    
    func addObserver() {
        self.addObserver(self, forKeyPath: "airPlayVideoActive", options: .New, context: nil)
        self.addObserver(self, forKeyPath: "externalPlaybackActive", options: .New, context: nil)

    }
    
    func addItemObserver() {
        self.currentItem?.addObserver(self, forKeyPath: "status", options: .New, context: nil)
        self.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .New, context: nil)
        self.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .New, context: nil)
        self.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: .New, context: nil)
        self.currentItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard keyPath != "status"
            || keyPath != "playbackBufferEmpty"
            || keyPath != "playbackBufferFull"
            || keyPath != "playbackLikelyToKeepUp"
            || keyPath != "loadedTimeRanges" else {
                return
        }
        delegate?.playerObserver(object as? AVPlayerItem, keyPath: keyPath, change: change)
    }
    
    func availableProgress() -> Double {
        let bufferTime = self.availableDuration()
        var result: Double = 0
        guard duration > 0 else {return 0}
        
        result = bufferTime / self.duration;
        return result
    }
    
    func availableDuration() -> Double {
        let ranges = self.currentItem?.loadedTimeRanges
        guard ranges?.count > 0  else {return 0}
        
        let timerange = ranges![0].CMTimeRangeValue
        let startSeconds = CMTimeGetSeconds(timerange.start)
        let durationSeconds = CMTimeGetSeconds(timerange.duration)
        return startSeconds + durationSeconds
    }
    
}
