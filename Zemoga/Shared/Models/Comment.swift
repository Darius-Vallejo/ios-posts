//
//  Comment.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
