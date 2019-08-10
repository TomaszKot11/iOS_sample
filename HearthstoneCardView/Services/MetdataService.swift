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
    
    
    public static func getRarityNameFor(id classId: Int) -> String {
        return ""
    }
    
    public static func getClassNameFor(id classId: Int) -> String {
        return ""
    }
    
    public static func queryApiForMetadata() {
        var apiUrlAllCards = URL(string: "https://us.api.blizzard.com/hearthstone/metadata")
        var request = URLRequest(url: apiUrlAllCards!)
        request.httpMethod = "GET"
        request.addValue("Bearer USko771Gzrjsq65zMVoKX7Tfht8Xi3EWFv", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
    
        //TODO: handle parsing exceptions?
        //TODO: use codable?
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                // HTTP 200 status
                //TODO: parse data
                let metadata = try JSONDecoder().decode(Metadata.self, from: data!)
    
                MetadataService.metadata = metadata
                print(metadata.classes.first)
            } catch let jsonErr {
                print("Error occured while parsing the JSON response:")
                print(jsonErr)
            }
        })
    
        task.resume()
    }
}
