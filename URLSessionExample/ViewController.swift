//
//  ViewController.swift
//  URLSessionExample
//
//  Created by ruslan on 23.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let newtworkManager = NetworkManager()
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
        
        newtworkManager.obtainPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                DispatchQueue.main.async {
                    self?.myTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
