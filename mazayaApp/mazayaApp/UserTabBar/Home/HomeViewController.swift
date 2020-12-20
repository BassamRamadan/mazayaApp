//
//  HomeViewController.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/17/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import AVKit
class HomeViewController: ContentViewController{

    @IBOutlet var videosCollection: UICollectionView!
    @IBOutlet var categoriesCollection: UICollectionView!
    @IBOutlet var cutomersCollection: UICollectionView!
    
    var videosArr = [videoData]()
    var categoriesArr = [brandItem]()
    var customersArr = [cutomerData]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "الرئيسية"
        categoriesArr.append(brandItem(brandText: "منتجات البناء", brandImage: #imageLiteral(resourceName: "ic_category_building")))
        categoriesArr.append(brandItem(brandText: "منتجات المنزل", brandImage: #imageLiteral(resourceName: "ic_category_home")))
        categoriesArr.append(brandItem(brandText: "منتجات لوجستية", brandImage: #imageLiteral(resourceName: "ic_categ_logistic")))
        
        getVideos(){
            data in
            self.videosArr.removeAll()
            self.videosArr.append(contentsOf: data)
            self.videosCollection.reloadData()
        }
        getCustomers(){
            data in
            self.customersArr.removeAll()
            self.customersArr.append(contentsOf: data)
            self.cutomersCollection.reloadData()
        }
    }
    @IBAction func allVideos(){
        openPageInTabBarWithIndex(index: 1)
    }
    @IBAction func allCustomers(){
        callStoryboard(name: "customers")
    }
}
extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == videosCollection{
            return videosArr.count
        }else if collectionView == categoriesCollection{
            return categoriesArr.count
        }else{
            return customersArr.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView == videosCollection ? 200 : 160, height: collectionView.contentSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if collectionView == videosCollection{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videos", for: indexPath) as! videoCell
            cell.videoTitle.text = videosArr[indexPath.row].title ?? ""
            let url = "https://img.youtube.com/vi/" + (getYoutubeId(youtubeUrl: videosArr[indexPath.row].url ?? "") ?? "") + "/hqdefault.jpg"
            cell.videoImage.sd_setImage(with: URL(string: url))
            return cell
        }else if collectionView == categoriesCollection{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! categoryCell
            cell.title.text = categoriesArr[indexPath.row].brandText
            cell.image.image = categoriesArr[indexPath.row].brandImage
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customers", for: indexPath) as! categoryCell
            cell.title.text = customersArr[indexPath.row].name ?? ""
            cell.image.setDefaultImage(url: customersArr[indexPath.row].mediaPath ?? "")
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == videosCollection{
            openWatchVideo(videoData: videosArr[indexPath.row])
        }else if collectionView == categoriesCollection{
            openPageInTabBarWithIndex(index: 2)
        }else{
            
        }
    }
    
}
