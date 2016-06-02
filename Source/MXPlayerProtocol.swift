//
//  MXPlayerProtocol.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/31.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

protocol MXPlayerProtocol {
    func prepareToplay() -> Void
    func play() -> Void
    func pause() -> Void
    func stop() -> Void
    func isPlayer() -> Bool
    func shutDown() -> Void
    func flashImage() -> UIImage
    
    var player: MXPlayer!{get}
    var playerView: MXPlayerView!{get}
    var currentTime: NSTimeInterval!{get set}
    var duration: NSTimeInterval!{get}
    var playableDuration: NSTimeInterval!{get}
    var bufferingProgress: Int64!{get}
    var isReady: Bool!{get}
    var movieState: MXPlayerMovieState!{get}
    var loadState: MXPlayerLoadState!{get}
    var numberOfBytesTransferred: Int64!{get}
    var naturalSize: CGSize!{get}
    var scalingMode: MXPlayerScaleMode!{get set}
    var shouldAutoPlay: Bool!{get set}
    var allowsMediaAirPlay :Bool!{get set}
    var isDanmakuMediaAirPlay: Bool!{get set}
    var airPlayMediaActive: Bool!{get}
    var playbackRate: Float!{get set}
}

protocol MXPlayerCallBack {
    func playerObserver(item: AVPlayerItem?, keyPath: String?, change: [String : AnyObject]?)
    func playerDidEndWithNoti(Noti: NSNotification)
    func playerFailedDidEndWithNoti(Noti: NSNotification)
}

extension MXPlayerCallBack {
    func playerDidEndWithNoti(Noti: NSNotification) {
        
    }
    func playerFailedDidEndWithNoti(Noti: NSNotification) {
        
    }

}