//
//  CardDetailsviewControllerViewController.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 31/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    var card: Card?
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCardImage()
    }
    
    private func displayCardImage() {
        if let card = card, let url = card.image["pl_PL"] {
            cardImageView.imageWithUrlString(link: url)
        }
    }
}
