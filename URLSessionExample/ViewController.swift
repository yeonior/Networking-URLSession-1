//
//  ViewController.swift
//  URLSessionExample
//
//  Created by ruslan on 23.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let session = URLSession.shared
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPosts()
    }
    
    func obtainPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error == nil, let parseData = data {
                
                do {
                    self.posts = try self.decoder.decode([Post].self, from: parseData)
                    print(self.posts)
                } catch {
                    print("Parsing went wrong!")
                }
                
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
}

