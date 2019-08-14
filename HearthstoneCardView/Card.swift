//
//  Card.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 07/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation

struct Card: Codable {
    let id: Int
    let manaCost: Int?
    let name: [String: String]
    let classId: String
    let cardTypeId: Int
    let image: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case manaCost = "manaCost"
        case name = "name"
        case classId = "classId"
        case cardTypeId = "cardTypeId"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        manaCost = try? container.decode(Int.self, forKey: .manaCost)
        name = try container.decode([String: String].self, forKey: .name)
        cardTypeId = try container.decode(Int.self, forKey: .cardTypeId)
        image = try container.decode([String: String].self, forKey: .image)
        if let value = try? container.decode(Int.self, forKey: .classId) {
            classId = String(value)
        } else {
            classId = try container.decode(String.self, forKey: .classId)
        }
    }
}

struct CardsPage: Codable {
    let cardCount: Int
    let cards: [Card]
    let page: Int
    let pageCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case cardCount = "cardCount"
        case cards = "cards"
        case page = "page"
        case pageCount = "pageCount"
    }
}
