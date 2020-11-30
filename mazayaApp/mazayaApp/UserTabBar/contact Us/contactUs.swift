//
//  contactUs.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/29/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class contactUs: common{
    @IBOutlet var phone: UILabel!
    @IBOutlet var website: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var userName: UITextField!
    @IBOutlet var userPhone: UITextField!
    @IBOutlet var userBody: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContacts(){
            data in
            self.phone.text = data.phone ?? ""
            self.website.text = data.website ?? ""
            self.email.text = data.email ?? ""
        }
        userName.delegate = self
        userPhone.delegate = self
        userBody.delegate = self
        setModules(userName)
        setModules(userPhone)
        setModules(userBody)
        setupBackButtonWithDismiss()
    }
    @IBAction func call(sender: UIButton){
        CallPhone(phone: self.phone.text ?? "")
    }
    fileprivate func setModules(_ textField : UIView){
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    @IBAction func sendMessage(){
        self.loading()
        let url = AppDelegate.LocalUrl + "send-message"
        let headers = [
            "Content-Type": "application/json",
            "Accept" : "application/json",
        ]
        let info = [
            "name": userName.text ?? "",
            "phone": userPhone.text ?? "",
            "message": userBody.text ?? ""
        ]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: info, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        self.present(common.makeAlert(message: "تم الارسال بنجاح"), animated: true, completion: nil)
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
extension contactUs : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor(named: "blue")?.cgColor
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        setModules(textField)
    }
}
extension contactUs : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.layer.borderColor = UIColor(named: "blue")?.cgColor
        if textView.text == "الرسالة"{
            textView.text = ""
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        setModules(textView)
    }
}
