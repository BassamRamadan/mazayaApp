//
//  customers.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/26/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class customers: common{
    @IBOutlet var cutomersCollection: UICollectionView!
    
    var customersArr = [cutomerData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButtonWithDismiss()
        getCustomers(){
            data in
            self.customersArr.removeAll()
            self.customersArr.append(contentsOf: data)
            self.cutomersCollection.reloadData()
        }
    }
}
extension customers: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customersArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-20)/2, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customers", for: indexPath) as! categoryCell
        cell.title.text = customersArr[indexPath.row].name ?? ""
        cell.image.setDefaultImage(url: customersArr[indexPath.row].mediaPath ?? "")
        return cell
    }
}
