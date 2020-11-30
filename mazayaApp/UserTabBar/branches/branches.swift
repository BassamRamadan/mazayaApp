//
//  branches.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/27/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class branches: ContentViewController{
    @IBOutlet var branchesTable: UITableView!
    var branchesAppeared: Array<Bool> = []
    var branchesArr: Array<branchData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        branchesTable.delegate = self
        branchesTable.dataSource = self
        getBranches(){
            data in
            self.branchesArr.removeAll()
            self.branchesArr.append(contentsOf: data)
            for _ in data{
                self.branchesAppeared.append(true)
            }
            self.branchesTable.reloadData()
        }
    }
    @IBAction func SectionClicked(sender: UIButton){
        branchesAppeared[sender.tag] = !branchesAppeared[sender.tag]
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, animations:  {
            self.branchesTable.reloadData()
        })
    }
    @IBAction func call(sender: UIButton){
        CallPhone(phone: self.branchesArr[sender.tag].phone ?? "")
    }
}
extension branches: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.branchesArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "branches", for: indexPath) as! branchCell
        cell.setupData(dataCell: branchesArr[indexPath.row], row: indexPath.row, isAppear: branchesAppeared[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if branchesAppeared[indexPath.row]{
            return 70
        }
        return 380
    }
}
