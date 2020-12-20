//
//  ViewController.swift
//  ios-swift-collapsible-table-section-in-grouped-section
//
//  Created by Yong Su on 5/31/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//
import UIKit
class menuController: common{
    // MARK: - Outlets
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet var username: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var image: UIImageView!
    
    var categories: [brandItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appendList()
    }
    fileprivate func appendList(){
        categories.append(brandItem(brandText: "الرئيسية", brandImage: #imageLiteral(resourceName: "ic_home_active")))
        categories.append(brandItem(brandText: "عملائنا الكرام", brandImage: #imageLiteral(resourceName: "ic_me_clients")))
        categories.append(brandItem(brandText: "من نحن..؟", brandImage: #imageLiteral(resourceName: "ic_me_about")))
        categories.append(brandItem(brandText: "الإشعارات والتنبيهات", brandImage: #imageLiteral(resourceName: "ic_me_notifcations")))
        categories.append(brandItem(brandText: "الفيديوهات", brandImage: #imageLiteral(resourceName: "ic_me_videos")))
        categories.append(brandItem(brandText: "منتجاتنا", brandImage: #imageLiteral(resourceName: "ic_catalog_active")))
        categories.append(brandItem(brandText: "فروعنا", brandImage: #imageLiteral(resourceName: "ic_me_branches")))
        updateConstraints()
    }
    func updateConstraints() {
        categoryCollectionView.layoutIfNeeded()
        categoryCollectionHeight.constant = categoryCollectionView.contentSize.height
    }
    @IBAction func callContactsStory(){
        callStoryboard(name: "contactUs")
    }
}
extension menuController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Cell width calculation
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceWidth = collectionView.frame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        
        return .init(width: referenceWidth, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! categoryCell
        cell.title.text = categories[indexPath.row].brandText
        cell.image.image = categories[indexPath.row].brandImage
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        openPages(row: indexPath.row)
    }
    
    
    func openPages(row: Int){
        switch row {
        case 1:
            callStoryboard(name: "customers")
            break
        case 2:
            callStoryboard(name: "aboutUs")
            break
        case 3:
            callStoryboard(name: "notifications")
            break
        default:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let linkingVC = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
                if row != 0{
                    linkingVC.tabBarIndex = row - 3
                }else{
                    linkingVC.tabBarIndex = 0
                }
                
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = linkingVC
        }
    }
    
}
struct brandItem {
    
    var brandText:String
    var brandImage:UIImage
    
}
