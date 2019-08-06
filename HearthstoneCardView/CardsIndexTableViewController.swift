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
    
        fetchFromApi()
        tableView.reloadData()
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
    
    func fetchFromApi() {
        // ?pageSize=20
        var pageNumber = (totalItems / customPageSize) + 1
        
        var apiUrlAllCards = URL(string: "https://us.api.blizzard.com/hearthstone/cards?pageSize=20&page=\(pageNumber)")
        var request = URLRequest(url: apiUrlAllCards!)
        request.httpMethod = "GET"
        request.addValue("Bearer USisOwtwACmyp1kIWeAWlWrdDGeLlLb7sb", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                print(json["page"])
               // print(json["cards"])
                print(json["cards"])
                
            } catch {
                print("error")
            }
        })
        
        task.resume()
        
        
        
//        tableView.reloadData()
    }
}
