//
//  Metadata.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 07/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation

// TOOD: internal struct?
struct CardClass: Codable {
    let id: String
    let slug: String
    let name: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slug = try container.decode(String.self, forKey: .slug)
        name = try container.decode([String: String].self, forKey: .name)
        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
    }
}

struct Rarity: Codable {
    let id: Int
    let slug: String
    let name: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
    }
}

struct Metadata: Codable {
    let rarities: [Rarity]
    let classes: [CardClass]
    
    private enum CodingKeys: String, CodingKey {
        case rarities = "rarities"
        case classes = "classes"
    }
}


