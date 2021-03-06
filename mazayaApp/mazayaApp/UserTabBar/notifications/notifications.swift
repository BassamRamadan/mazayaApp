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
extension notifications: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
extension notifications: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if notificationArr.count == 0{
            noDataAvailable(collectionView,message: "لا يوجد تنبيهات حاليا")
        }
        return notificationArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 170)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notifications", for: indexPath) as! notificationCell
        cell.date.text = notificationArr[indexPath.row].createdAt ?? ""
        cell.content.text = notificationArr[indexPath.row].content ?? ""
        cell.content.delegate = self
        return cell
    }
    
}
