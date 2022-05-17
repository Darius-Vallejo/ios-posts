//
//  PostsRouter.swift
//  Zemoga
//
//  Created by darius vallejo on 5/11/22.
//

import Foundation
import UIKit

protocol IPostsRouter: AnyObject {
    var entry: UINavigationController? { get }
    static func start() -> IPostsRouter
    
    func goToDetail(post: Post, delegate: PostsScreenDelegate)
}

class PostsRouter: IPostsRouter {
    weak var entry: UINavigationController?
    
    static func start() -> IPostsRouter {
        let router = PostsRouter()
        
        let interactor: IPostsInteractor = PostsInteractor()
        var presenter: IPostsPresenter = PostsPresenter(interactor: interactor)
        let controller = PostsMainViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: controller)
        
        presenter.router = router
        presenter.postsFeedView = controller
        router.entry = navigationController
        
        return router
    }
    
    func goToDetail(post: Post, delegate: PostsScreenDelegate) {
        let detailRouter = DetailRouter.start(with: post, andScreenDelegate: delegate)
        guard let detailViewController = detailRouter.entry else {
            return
        }
        entry?.pushViewController(detailViewController, animated: true)
    }
}
