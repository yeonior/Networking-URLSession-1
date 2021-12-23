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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainPosts()
    }
    
    func obtainPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil {
                print("Success!")
            }
        }
        
        dataTask.resume()
    }
}

