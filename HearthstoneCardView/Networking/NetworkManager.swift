//
//  NetworkManager.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 31/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import Foundation


class NetworkManager {
    
    public static func fetchFromApi(withURL url: String, withHandler handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let apiUrl = URL(string: url) else { return }
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        request.addValue(NetworkConstants.ApiToken, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: handler)
        
        task.resume()
    }
}
