//
//  notifications.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/29/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
class notifications: common{
    @IBOutlet var notificationCollection : UICollectionView!
    var notificationArr = [notificationData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButtonWithDismiss()
        getNotifications(){
            data in
            self.notificationArr.removeAll()
            self.notificationArr.append(contentsOf: data)
            self.notificationCollection.reloadData()
        }
        
    }
}
extension notifications: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notifications", for: indexPath) as! notificationCell
        cell.date.text = notificationArr[indexPath.row].createdAt ?? ""
        cell.content.text = notificationArr[indexPath.row].content ?? ""
       
        return cell
    }
    
}
