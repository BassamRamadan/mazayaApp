//
//  aboutUs.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/29/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class aboutUs: common{
    
    @IBOutlet var name: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var video: YTPlayerView!

    var aboutusData: aboutusData?
    var contacts: contactsData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAboutUs()
        getContacts(){
            data in
            self.contacts = data
        }
        setupBackButtonWithDismiss()        
    }
    @IBAction func whats(sender: UIButton){
        switch sender.tag{
        case 2:
            openNewTab(url: contacts?.instagram ?? "")
            break
        case 3:
            openNewTab(url: contacts?.twitter ?? "")
            break
        default:
            openNewTab(url: contacts?.facebook ?? "")
        }
    }
    @IBAction func downloadFile(){
        openNewTab(url: aboutusData?.filePath ?? "")
    }
    
    func setupData(data: aboutusData){
        aboutusData = data
        name.text = data.title ?? ""
        content.text = data.content ?? ""
        video.load(withVideoId: getYoutubeId(youtubeUrl: data.url ?? "") ?? "", playerVars: ["playsinline":1])
    }
    func getAboutUs(){
        self.loading()
        let url = AppDelegate.LocalUrl + "about-us"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        let dataReceived = try decoder.decode(aboutusJson.self, from: jsonData)
                        self.setupData(data: dataReceived.data!)
                    }else{
                        self.present(common.makeAlert(), animated: true, completion: nil)
                    }
                    self.stopAnimating()
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            }catch {
                self.present(common.makeAlert(), animated: true, completion: nil)
                self.stopAnimating()
            }
        }
    }
}

