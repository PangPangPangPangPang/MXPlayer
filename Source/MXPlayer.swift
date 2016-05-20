//
//  MXPlayer.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

@objc public protocol MXPlayerDelegate: NSObjectProtocol {
    func playerObserver(item: AVPlayerItem?, keyPath: String?, change: [String : AnyObject]?)
    optional func playerDidEndWithNoti(Noti: NSNotification)
    optional func playerFailedDidEndWithNoti(Noti: NSNotification)
}

class MXPlayer: AVPlayer {
    var delegate: MXPlayerDelegate?
    var currentTime: Double! = 0
    var duration: Double! = 0
    var progress: Double! = 0
    
    override init() {
        super.init()
    }
    
    init(item: AVPlayerItem, delegate: MXPlayerDelegate) {
        super.init(playerItem: item)
        self.delegate = delegate
        self.addObserver()
    }
    
    func addObserver() {
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
        guard delegate == nil || (delegate?.respondsToSelector(#selector(MXPlayerDelegate.playerObserver(_:keyPath:change:))))! else {return}
        delegate?.playerObserver(object as? AVPlayerItem, keyPath: keyPath, change: change)
        
    }
    
    
}
