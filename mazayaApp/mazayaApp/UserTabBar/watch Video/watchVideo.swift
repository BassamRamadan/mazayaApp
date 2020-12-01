//
//  watchVideo.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/26/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class watchVideo: common , YTPlayerViewDelegate{
    @IBOutlet var videoView: YTPlayerView!
    @IBOutlet var date: UILabel!
    @IBOutlet var details: UILabel!
    
    var contacts: contactsData?
    var video: videoData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContacts(){
            data in
            self.contacts = data
        }
        videoView.delegate = self
        videoView.load(withVideoId: getYoutubeId(youtubeUrl: video?.url ?? "") ?? "", playerVars: ["playsinline": 1])
        date.text = video?.createdAt ?? ""
        details.text = video?.title ?? ""
    }
    @IBAction func back(){
        dismiss(animated: true)
    }
    @IBAction func whats(sender: UIButton){
        switch sender.tag{
        case 1:
            callWhats(whats: contacts?.phone ?? "")
            break
        case 2:
            if let url = URL(string: contacts?.instagram ?? "") {
                UIApplication.shared.open(url)
            }
            break
        case 3:
            if let url = URL(string: contacts?.twitter ?? "") {
                UIApplication.shared.open(url)
            }
            break
        default:
            if let url = URL(string: contacts?.facebook ?? "") {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
