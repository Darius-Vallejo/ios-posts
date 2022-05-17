//
//  DetailInteractor.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation
import Combine

protocol IDetailInteractor {
    var post: Post { get }
    var comments: [Comment] { get }
    var user: User? { get }
    var dataManagerPublisher: CurrentValueSubject<PostsUpdater, NetworkErrors> { get }
    
    func loadModels()
    func update(when isFavorite: Bool)
}

class DetailInteractor: IDetailInteractor {
    private(set) var post: Post
    private(set) var comments: [Comment] = []
    private(set) var user: User?
    private(set) var dataManagerPublisher = CurrentValueSubject<PostsUpdater,
                                                                NetworkErrors>(.newComentsLoaded([]) )
    private var cancellables: Set<AnyCancellable> = []
    private var services: IPostServices
    
    init(post: Post, services: IPostServices = Services.shared()) {
        self.services = services
        self.post = post
        dataManagerPublisher
            .sink {
                print($0)
            } receiveValue: { [unowned self] in
                self.loadConent(by: $0)
            }.store(in: &cancellables)

    }
    
    func loadConent(by updater: PostsUpdater) {
        switch updater {
        case .newComentsLoaded(let comments):
            self.comments = comments
        case .newUserLoaded(let user):
            self.user = user
        case .updatePost(let post):
            self.post = post
        default:
            break
        }
    }
    
    private func loadCommentsAndUser() {
        services
            .comments(by: post.id)
            .replaceError(with: [])
            .map {
                return PostsUpdater.newComentsLoaded($0)
            }
            .eraseToAnyPublisher()
            .assign(to: \.value, on: dataManagerPublisher)
            .store(in: &cancellables)
        
        services
            .user(userId: post.userId)
            .replaceError(with: [])
            .map {
                return PostsUpdater.newUserLoaded($0[0])
            }
            .eraseToAnyPublisher()
            .assign(to: \.value, on: dataManagerPublisher)
            .store(in: &cancellables)
    }
    
    func loadModels() {
        loadCommentsAndUser()
    }
    
    func update(when isFavorite: Bool) {
        var newPost = post
        newPost.isFavorite = isFavorite
        dataManagerPublisher.send(.updatePost(post: newPost))
    }
}
