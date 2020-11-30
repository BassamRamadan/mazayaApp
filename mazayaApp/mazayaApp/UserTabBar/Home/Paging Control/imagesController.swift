//
//  imagesController.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/17/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class imagesController: common {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var horizontalScrollView: UIScrollView!
    
    var BannersArr = [bannerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.numberOfPages = 0
        getBanners()
    }
    
    fileprivate func setupHorizontalScrollView(){
        horizontalScrollView.delegate = self
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.showsVerticalScrollIndicator = false
        let items = HorizontalItemList(inView: horizontalScrollView,arrangedSubviews: BannersArr)
        horizontalScrollView.addSubview(items)
        items.fillSuperview()
        
        pageControl.numberOfPages = BannersArr.count
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    // MARK:- Alamofire
    fileprivate func getBanners(){
        self.loading()
        let url = AppDelegate.LocalUrl + "banners"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        let dataReceived = try decoder.decode(bannersJson.self, from: jsonData)
                        self.BannersArr.removeAll()
                        self.BannersArr.append(contentsOf: dataReceived.data ?? [])
                        self.setupHorizontalScrollView()
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
extension imagesController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pagWidth = scrollView.bounds.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / pagWidth)
    }
}
