//
//  MetdataService.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 10/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation
import UIKit

// As far as I managed to know such classes are antipattern in iOS world? ;>
class MetadataService {
   public static var metadata: Metadata?
    
    public static func getRarityNameAndColorFor(id rarityId: Int) -> (name: String?, color: UIColor?) {
        if let rarities = metadata?.rarities, let rarity = rarities.first(where: { $0.id == rarityId }) {
            return (rarity.name["pl_PL"], getColorForRarityName(rarityName: rarity.name["en_US"]))
        }
        
        return (nil, nil)
    }
    
    public static func getClassNameFor(id classId: String) -> String? {
        if let cardClasses = metadata?.classes {
            let cardClass: CardClass? = cardClasses.first(where: { $0.id == classId })
            
            return cardClass?.name["pl_PL"]
        }
        
        return nil
    }
    
    public static func queryApiForMetadata() {
        let apiUrlAllCards = URL(string: "https://us.api.blizzard.com/hearthstone/metadata")
        var request = URLRequest(url: apiUrlAllCards!)
        request.httpMethod = "GET"
        request.addValue("Bearer USb9M27894qSS1h81NmzDsW9wKE7ckq11H", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let metadata = try JSONDecoder().decode(Metadata.self, from: data!)
                MetadataService.metadata = metadata
            } catch let jsonErr {
                print("Error occured while parsing the JSON response:")
                print(jsonErr)
            }
        })
    
        task.resume()
    }
}


// returns color for giver Rarity string
extension MetadataService {
    private static func getColorForRarityName(rarityName: String?) -> UIColor? {
        switch(rarityName) {
        case "Epic":
            return UIColor.purple
        case "Rare":
            return UIColor.blue
        case "Common":
            return UIColor.gray
        case "Legendary":
            return UIColor.orange
        default:
            return nil
        }
    }
}
