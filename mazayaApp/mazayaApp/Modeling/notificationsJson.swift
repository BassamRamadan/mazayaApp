//
//  notificationsJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/29/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class notificationsJson: Codable {
    let code: Int?
    let message: String?
    let data: [notificationData]?
    
    init(code: Int?, message: String?, data: [notificationData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class notificationData: Codable {
    let id: Int?
    let content: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, content
        case createdAt = "created_at"
    }
    
    init(id: Int?, content: String?, createdAt: String?) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
}
