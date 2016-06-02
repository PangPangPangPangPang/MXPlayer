//
//  MXPlayerEnum.swift
//  MXPlayer
//
//  Created by Max Wang on 16/6/2.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import Foundation

enum MXPlayerMovieState {
    case stopped
    case playing
    case paused
    case interrupted
    case seekingForward
    case seekingBackword
}

enum MXPlayerScaleMode {
    case none, aspectFit, aspectFill, Fill
}

enum MXPlayerFinishState {
    case ended, failed, exited
}

enum MXPlayerTimeOption {
    case exact, keyframe
}

enum MXPlayerLoadState {
    case unknown, playable, throughOK, stalled, failed
}

enum MXPlayerBufferState {
    case unknown, empty, keepUp, full
}