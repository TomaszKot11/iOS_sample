//
//  CardsIndexTableViewController.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 06/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CardsIndexTableViewController: UITableViewController {
    
    var fetchedDictionary: Dictionary<String, String> = [:]
    var totalItems: Int = 0
    let customPageSize: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //fetchMetadata()
//        fetchFromApi()
//        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // check pagination
        if indexPath.row == fetchedDictionary.count - 1 {
            if totalItems > fetchedDictionary.count {
                fetchFromApi()
                totalItems += customPageSize
                tableView.reloadData()
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath)
        

        return cell
    }
    
    
    public func fetchMetadata() {
        
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
                
                print(metadata.classes.first)
            } catch let jsonErr {
                print("Error occured while parsing the JSON response:")
                print(jsonErr)
            }
        })
        
        task.resume()
        
        
    }
    
    func fetchFromApi() {
        // ?pageSize=20
        var pageNumber = (totalItems / customPageSize) + 1
        
        var apiUrlAllCards = URL(string: "https://us.api.blizzard.com/hearthstone/cards?pageSize=20&page=\(pageNumber)")
        var request = URLRequest(url: apiUrlAllCards!)
        request.httpMethod = "GET"
        request.addValue("Bearer USko771Gzrjsq65zMVoKX7Tfht8Xi3EWFv", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        //TODO: handle parsing exceptions?
        //TODO: use codable?
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                
               let cards = json["cards"] as! [Any]
                
                for (index, card) in cards.enumerated() {
                    if index == 0 {
//                        print(card)
                        let jsonDict = card as! Dictionary<String, Any>
//                        print(jsonDict["artistName"])

                        let nameDict = jsonDict["name"] as! Dictionary<String, Any>
//                        print(nameDict["pl_PL"])
//                        print(jsonDict["classId"])
//                        print(jsonDict["rarityId"])
//                        print(jsonDict["manaCost"])

//                        print(jsonDict["name"]["pl_PL"])
//                        print(jsonDict["name"]["pl_PL"])
//                        print(jsonDict["name"]["pl_PL"])
//                        print(jsonDict["name"]["pl_PL"])

                    }
                    
//                    let decoder = JSONDecoder()
//                    do {
//                        let decodedCard = try decoder.decode(Card.self, from: card as! Data)
//                        print(decodedCard)
//                    } catch let error {
//                        print(error)
//                    }
                    
                }
                
                //print(json["page"])
               // print(json["cards"])
               // print(json["cards"])
//                for data in json["cards"] as! Dictionary<String, Any> {
//                    print("-------")
//                    print(data)
//                    print("-------")
//                }
                
            } catch {
                print("error")
            }
        })
        
        task.resume()
        
        
        
//        tableView.reloadData()
    }
}
