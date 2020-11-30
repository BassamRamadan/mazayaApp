//
//  videosJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

class videosJson: Codable {
    let code: Int?
    let message: String?
    let data: [videoData]?
    
    init(code: Int?, message: String?, data: [videoData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class videoData: Codable {
    let id: Int?
    let title: String?
    let url: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, url
        case createdAt = "created_at"
    }
    
    init(id: Int?, title: String?, url: String?, createdAt: String?) {
        self.id = id
        self.title = title
        self.url = url
        self.createdAt = createdAt
    }
}
