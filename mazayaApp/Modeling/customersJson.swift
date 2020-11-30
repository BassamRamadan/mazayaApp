//
//  customersJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

class cutomersJson: Codable {
    let code: Int?
    let message: String?
    let data: [cutomerData]?
    
    init(code: Int?, message: String?, data: [cutomerData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class cutomerData: Codable {
    let id: Int?
    let name: String?
    let mediaPath: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case mediaPath = "media_path"
        case createdAt = "created_at"
    }
    
    init(id: Int?, name: String?, mediaPath: String?, createdAt: String?) {
        self.id = id
        self.name = name
        self.mediaPath = mediaPath
        self.createdAt = createdAt
    }
}
