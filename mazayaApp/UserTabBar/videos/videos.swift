//
//  videos.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class videos: ContentViewController{
    @IBOutlet var videosCollection: UICollectionView!
    var videosArr = [videoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "الفيديوهات"
        getVideos(){
            data in
            self.videosArr.removeAll()
            self.videosArr.append(contentsOf: data)
            self.videosCollection.reloadData()
        }
    }
    
}
extension videos: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20)/2, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videos", for: indexPath) as! videoCell
        cell.videoTitle.text = videosArr[indexPath.row].title ?? ""
        cell.videoView.load(withVideoId: videosArr[indexPath.row].url ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        openWatchVideo(videoData: videosArr[indexPath.row])
    }
    
}
