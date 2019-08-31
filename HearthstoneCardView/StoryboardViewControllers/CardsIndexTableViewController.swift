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
    
    var cards: [Card] = []
    var cardPages: [CardsPage] = []
    var selectedCard: Card?
    var totalItems: Int {
        get {
            return cards.count
        }
    }
    let customPageSize: Int = 20
    
    override func viewDidLoad() {
        // initial fetch from API
        fetchFromApi()
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == totalItems - 1 {
            fetchFromApi()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell") as? CustomTableViewCell
        if cell == nil {
            cell = CustomTableViewCell(style: .default, reuseIdentifier: "CardTableViewCell")
        }
        
        cell!.feedWithCard(card: cards[indexPath.row])
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedCard = self.cards[indexPath.row]
        
        performSegue(withIdentifier: "CardDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CardDetailsSegue" {
            if let vc = segue.destination as? CardDetailsViewController {
                vc.card = selectedCard
            }
        }
    }
    
    
    func fetchFromApi(isInitialFetch: Bool = false) {
        var pageNumber = (totalItems / customPageSize) + 1
        
        var apiUrlAllCards = URL(string: "https://us.api.blizzard.com/hearthstone/cards?pageSize=\(customPageSize)&page=\(pageNumber)")
        var request = URLRequest(url: apiUrlAllCards!)
        request.httpMethod = "GET"
        request.addValue("Bearer USb9M27894qSS1h81NmzDsW9wKE7ckq11H", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
            let jsonOne = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
             let cardPage = try JSONDecoder().decode(CardsPage.self, from: data!)
                //TODO: think over this solution - is it good
                DispatchQueue.main.async {
                    self.cardPages.append(cardPage)
                    self.cards.append(contentsOf: cardPage.cards)
                    self.tableView.reloadData()
                }
            } catch let err {
                print(err)
                print(err.localizedDescription)
                print("error")
            }
        })
        
        task.resume()
    }
}
