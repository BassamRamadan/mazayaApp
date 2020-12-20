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
    @IBAction func share(){
        let activityController = UIActivityViewController(activityItems: [video?.url ?? ""], applicationActivities: nil)
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            navigationItem.setLeftBarButton(UIBarButtonItem(customView: UIButton()), animated: false)
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [video?.url ?? ""], applicationActivities: nil)
            present(activityVC, animated: true)
            if let popOver = activityVC.popoverPresentationController {
                popOver.barButtonItem = navigationItem.leftBarButtonItem
                //popOver.barButtonItem
            }
        } else {
            present(activityController, animated: true)
        }
    }
    
}
