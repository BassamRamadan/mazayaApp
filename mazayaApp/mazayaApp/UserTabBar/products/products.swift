//
//  products.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/27/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
class products: ContentViewController{
    
    var catalog: catalogData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCatalog()
    }
    @IBAction func downloadFile(){
        if let url = URL(string: catalog?.mediaPath ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func getCatalog(){
        self.loading()
        let url = AppDelegate.LocalUrl + "product"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        let dataReceived = try decoder.decode(catalogJson.self, from: jsonData)
                        self.catalog = dataReceived.data!
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
