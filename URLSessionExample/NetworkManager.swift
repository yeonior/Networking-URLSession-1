//
//  NetworkManager.swift
//  URLSessionExample
//
//  Created by Ruslan on 24.12.2021.
//

import Foundation

enum ObtainPostsResult {
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager {
    
    let session = URLSession.shared
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    
    func obtainPosts(completion: @escaping (ObtainPostsResult) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            
            var result: ObtainPostsResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let self = self else { return result = .success(posts: []) }
            
            if error == nil, let parseData = data {
                
                do {
                    let posts = try self.decoder.decode([Post].self, from: parseData)
                    result = .success(posts: posts)
                } catch let error {
                    result = .failure(error: error)
                }
                
            } else if let error = error {
                result = .failure(error: error)
            } else {
                result = .success(posts: [])
            }
        }
        
        dataTask.resume()
    }
}
