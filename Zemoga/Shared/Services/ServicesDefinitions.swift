//
//  ServicesDefinitions.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation

struct ServicesDefinitions {
    static let posts = "https://jsonplaceholder.typicode.com/posts"
    
    static let comments: (_ postId: Int) -> String = {
        return "https://jsonplaceholder.typicode.com/comments?postId=\($0)"
    }
    
    static let users: (_ userId: Int) -> String = {
        return "https://jsonplaceholder.typicode.com/users?id=\($0)"
    }
}
