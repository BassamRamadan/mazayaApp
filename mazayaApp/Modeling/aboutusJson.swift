//
//  aboutJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/30/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class aboutusJson: Codable {
    let code: Int?
    let message: String?
    let data: aboutusData?
    
    init(code: Int?, message: String?, data: aboutusData?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class aboutusData: Codable {
    let id: Int?
    let title, content: String?
    let url: String?
    let videoPath, filePath: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, url
        case videoPath = "video_path"
        case filePath = "file_path"
        case createdAt = "created_at"
    }
    
    init(id: Int?, title: String?, content: String?, url: String?, videoPath: String?, filePath: String?, createdAt: String?) {
        self.id = id
        self.title = title
        self.content = content
        self.url = url
        self.videoPath = videoPath
        self.filePath = filePath
        self.createdAt = createdAt
    }
}
