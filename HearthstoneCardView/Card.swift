//
//  Card.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 07/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation


class Card {
    let cardBaseData: CardBaseData!
    
    init(fromCardBasedata cardBaseData: CardBaseData!) {
        self.cardBaseData = cardBaseData
    }
}

struct CardBaseData {
    let name: String
    let manaCost: Int
    let rarityId: Int
    let classId: Int
}
