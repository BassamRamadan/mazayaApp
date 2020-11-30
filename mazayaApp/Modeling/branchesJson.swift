//
//  branchesJson.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/27/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class branchesJson: Codable {
    let code: Int?
    let message: String?
    let data: [branchData]?
    
    init(code: Int?, message: String?, data: [branchData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class branchData: Codable {
    let id: Int?
    let name, phone, fax, lat: String?
    let lon: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, phone, fax, lat, lon
        case createdAt = "created_at"
    }
    
    init(id: Int?, name: String?, phone: String?, fax: String?, lat: String?, lon: String?, createdAt: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.fax = fax
        self.lat = lat
        self.lon = lon
        self.createdAt = createdAt
    }
}
