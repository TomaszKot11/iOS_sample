//
//  Card.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 07/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation

// to deserialize single Card JSON object
struct Card: Codable {
    let id: Int
    let manaCost: Int?
    let name: [String: String]
    let classId: String
    let cardTypeId: Int
    let rarityId: Int
    let image: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case manaCost = "manaCost"
        case name = "name"
        case classId = "classId"
        case cardTypeId = "cardTypeId"
        case image = "image"
        case rarityId = "rarityId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        manaCost = try? container.decode(Int.self, forKey: .manaCost)
        name = try container.decode([String: String].self, forKey: .name)
        cardTypeId = try container.decode(Int.self, forKey: .cardTypeId)
        image = try container.decode([String: String].self, forKey: .image)
        rarityId = try container.decode(Int.self, forKey: .rarityId)
        if let value = try? container.decode(Int.self, forKey: .classId) {
            classId = String(value)
        } else {
            classId = try container.decode(String.self, forKey: .classId)
        }
    }
}

// to deserialize CardsPage JSON object
struct CardsPage: Codable {
    let cardCount: Int
    let cards: [Card]
    let page: Int
    let pageCount: Int
}
