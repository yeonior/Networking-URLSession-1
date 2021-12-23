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
    
    let myTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        view.addSubview(myTableView)
        myTableView.frame = view.bounds
        myTableView.dataSource = self
        obtainPosts()
    }
    
    func obtainPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error == nil, let parseData = data {
                
                do {
                    self.posts = try self.decoder.decode([Post].self, from: parseData)
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
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

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        
        return cell
    }
    
    
}
