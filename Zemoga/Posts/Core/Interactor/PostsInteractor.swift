//
//  PostsInteractor.swift
//  Zemoga
//
//  Created by darius vallejo on 5/11/22.
//

import Foundation
import Combine

protocol IPostsInteractor {
    var posts: [Post] { get }
    var postsPublisher: CurrentValueSubject<PostsUpdater, NetworkErrors> { get }
    
    func loadPosts()
    func updateCurrentList(by post: Post)
    func removePostFromList(post: Post)
    func removeAll()
}

class PostsInteractor: IPostsInteractor {
    
    private(set) var posts: [Post] = []
    private var cancellables: Set<AnyCancellable> = []
    var postsPublisher = CurrentValueSubject<PostsUpdater, NetworkErrors>(.newPostsLoaded([]))
    private var services: IPostServices

    init(services: IPostServices = Services.shared()) {
        self.services = services
        postsPublisher
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] in
                self?.postsHanlder(for: $0)
            }).store(in: &cancellables)
    }
    
    private func postsHanlder(for updater: PostsUpdater) {
        if case .newPostsLoaded(let posts) = updater {
            let sortedPost = posts.sorted {
                return $0.isFavorite ?? false && !($1.isFavorite ?? false)
            }
            self.posts = sortedPost
        }
    }
    
    func loadPosts() {
        services
            .posts()
            .replaceError(with: [])
            .map {
                return PostsUpdater.newPostsLoaded($0)
            }
            .eraseToAnyPublisher()
            .sink(receiveValue: { [weak self] in
                self?.postsHanlder(for: $0)
                self?.postsPublisher.send($0)
            }).store(in: &cancellables)
            
    }
    
    private func postIndexFromList(_ post: Post) -> Int? {
        let updatedPostIndex = posts.firstIndex(where: { $0.id == post.id })
        return updatedPostIndex
    }
    
    func updateCurrentList(by post: Post) {
        guard let updatedPostIndex = postIndexFromList(post) else {
            return
        }
        var updatedPosts = posts
        updatedPosts[updatedPostIndex] = post
        postsPublisher.send(.newPostsLoaded(updatedPosts))
    }
    
    func removePostFromList(post: Post) {
        guard let updatedPostIndex = postIndexFromList(post) else {
            return
        }
        var updatedPosts = posts
        updatedPosts.remove(at: updatedPostIndex)
        postsPublisher.send(.newPostsLoaded(updatedPosts))
    }
    
    func removeAll() {
        postsPublisher.send(.newPostsLoaded([]))
    }
}
