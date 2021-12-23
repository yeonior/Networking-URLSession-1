//
//  Post.swift
//  URLSessionExample
//
//  Created by Ruslan on 23.12.2021.
//

import Foundation

struct Post: Codable {
    
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}
