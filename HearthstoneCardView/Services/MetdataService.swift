//
//  MetdataService.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 10/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation


class MetadataService {
     public static var metadata: Metadata?
    
    
    public static func getRarityNameFor(id rarityId: Int) -> String? {
        if let rarities = metadata?.rarities {
            
            let rarity: Rarity? = rarities.first(where: { $0.id == rarityId })
           
            return rarity?.name["pl_PL"]
        }
        
        return nil
    }
    
    public static func getClassNameFor(id classId: String) -> String? {
        if let cardClasses = metadata?.classes {
            let cardClass: CardClass? = cardClasses.first(where: { $0.id == classId })
            
            return cardClass?.name["pl_PL"]
        }
        
        return nil
    }
    
    public static func queryApiForMetadata() {
        var apiUrlAllCards = URL(string: "https://us.api.blizzard.com/hearthstone/metadata")
        var request = URLRequest(url: apiUrlAllCards!)
        request.httpMethod = "GET"
        request.addValue("Bearer USaKUzz15BIXKWUXuylHrEOTUoPVoJBS5C", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
    
        //TODO: handle parsing exceptions?
        //TODO: use codable?
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                // HTTP 200 status
                //TODO: parse data
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
