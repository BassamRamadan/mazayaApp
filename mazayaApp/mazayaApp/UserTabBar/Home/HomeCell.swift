//
//  HomeCell.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/17/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class videoCell: UICollectionViewCell {
    @IBOutlet var videoTitle: UILabel!
    @IBOutlet var videoView: YTPlayerView!
    @IBOutlet var videoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
