//
//  Post.swift
//  Zemoga
//
//  Created by darius vallejo on 5/11/22.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
