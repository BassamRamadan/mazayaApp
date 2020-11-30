//
//  bannerJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

class bannersJson: Codable {
    let code: Int?
    let message: String?
    let data: [bannerData]?
    
    init(code: Int?, message: String?, data: [bannerData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class bannerData: Codable {
    let id: Int?
    let mediaPath: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaPath = "media_path"
        case createdAt = "created_at"
    }
    
    init(id: Int?, mediaPath: String?, createdAt: String?) {
        self.id = id
        self.mediaPath = mediaPath
        self.createdAt = createdAt
    }
}
