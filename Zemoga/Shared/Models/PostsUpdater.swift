//
//  PostsUpdater.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation

enum PostsUpdater {
    case newPostsLoaded(_ posts: [Post])
    case newComentsLoaded(_ comments: [Comment])
    case newUserLoaded(_ user: User?)
    case updatePost(post: Post)
}
