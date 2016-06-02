//
//  AudioSessionManager.swift
//  MXPlayer
//
//  Created by Max Wang on 16/6/2.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import Foundation
import AVFoundation


class AudioSessionManager: NSObject {
    static let shareInstance: AudioSessionManager = AudioSessionManager()
    var iniatialized: Bool = false
    
    func audioSession() -> Void {
        if !iniatialized {
                    NSNotificationCenter.defaultCenter().addObserver(AudioSessionManager.shareInstance, selector: #selector(AudioSessionManager.handleInterrupt(_:)), name: AVAudioSessionInterruptionNotification, object: AVAudioSession.sharedInstance())
            iniatialized = true
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func setActive(active: Bool) -> Void {
        do {
            try AVAudioSession.sharedInstance().setActive(active)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    func handleInterrupt(noti: NSNotification) -> Void {
        guard noti.name == AVAudioSessionInterruptionNotification && noti.userInfo != nil else {
            return
        }
        
        if let typenumber = noti.userInfo?[AVAudioSessionInterruptionTypeKey]?.unsignedIntegerValue {
            switch typenumber {
            case AVAudioSessionInterruptionType.Began.rawValue:
                self.setActive(false)
            case AVAudioSessionInterruptionType.Ended.rawValue:
                self.setActive(false)
            default:
                break
            }
        }
    }
}
