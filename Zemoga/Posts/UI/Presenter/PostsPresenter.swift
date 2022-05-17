//
//  PostsPresenter.swift
//  Zemoga
//
//  Created by darius vallejo on 5/11/22.
//

import Foundation
import Combine

protocol PostsDataManager: AnyObject {
    var posts: [Post] { get }
    
    func loadDetail(by post: Post)
}

protocol PostsScreenDelegate: AnyObject {
    func update(post: Post)
    func remove(post: Post)
}

protocol IPostsPresenter {
    var router: IPostsRouter? { get set }
    var postsFeedView: IPostsMainViewController? { get set }
    var dataSourceDelegate: TableViewDataDelegate { get }
    
    func loadPosts()
    func removeAll()
}

class PostsPresenter: IPostsPresenter {
    
    var router: IPostsRouter?
    private var interactor: IPostsInteractor
    weak var postsFeedView: IPostsMainViewController?
    private var cancellables: Set<AnyCancellable> = []
    
    lazy var dataSourceDelegate: TableViewDataDelegate = {
        PostsFeedDataSourceDelegate(dataDelegate: self)
    }()
    
    init(interactor: IPostsInteractor) {
        self.interactor = interactor
        interactor
            .postsPublisher
            .replaceError(with: .newPostsLoaded([]))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] _ in
                self.postsFeedView?.reloadData()
            })
            .store(in: &cancellables)
    }
    
    func loadPosts() {
        interactor.loadPosts()
    }

    func removeAll() {
        interactor.removeAll()
    }
}

extension PostsPresenter: PostsDataManager {
    var posts: [Post] {
        return interactor.posts
    }
    
    func loadDetail(by post: Post) {
        router?.goToDetail(post: post, delegate: self)
    }
}
extension PostsPresenter: PostsScreenDelegate {
    func remove(post: Post) {
        interactor.removePostFromList(post: post)
    }
    
    func update(post: Post) {
        interactor.updateCurrentList(by: post)
    }
}
