//
//  contactsJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

class contactsJson: Codable {
    let code: Int?
    let message: String?
    let data: contactsData?
    
    init(code: Int?, message: String?, data: contactsData?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class contactsData: Codable {
    let id: Int?
    let facebook, twitter, instagram: String?
    let phone, email: String?
    let website: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, facebook, twitter, instagram, phone, email, website
        case createdAt = "created_at"
    }
    
    init(id: Int?, facebook: String?, twitter: String?, instagram: String?, phone: String?, email: String?, website: String?, createdAt: String?) {
        self.id = id
        self.facebook = facebook
        self.twitter = twitter
        self.instagram = instagram
        self.phone = phone
        self.email = email
        self.website = website
        self.createdAt = createdAt
    }
}
