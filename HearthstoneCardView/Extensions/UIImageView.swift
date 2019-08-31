//
//  UIImageView.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 31/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    // extenstion method for fetching image uisng provided URL as String
    func imageWithUrlString(link: String, contetn mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        self.contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let httpURLResponse = response as? HTTPURLResponse
            if let httpURLResponse = httpURLResponse, httpURLResponse.statusCode == 200, error == nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
