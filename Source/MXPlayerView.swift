//
//  MXPlayerView.swift
//  MXPlayer
//
//  Created by Max Wang on 16/5/20.
//  Copyright © 2016年 Max Wang. All rights reserved.
//

import UIKit
import AVFoundation

class MXPlayerView: UIView {
    internal override class func layerClass() -> AnyClass {
        return AVPlayerLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(player: MXPlayer,frame: CGRect) {
        super.init(frame: frame)
        if let layer:AVPlayerLayer = self.layer as? AVPlayerLayer {
            layer.player = player
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
