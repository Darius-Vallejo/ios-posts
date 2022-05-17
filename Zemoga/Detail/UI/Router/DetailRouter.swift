//
//  DetailRouter.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation
import UIKit

protocol IDetailRouter {
    var entry: UIViewController? { get }
    static func start(with post: Post,
                      andScreenDelegate delegate: PostsScreenDelegate) -> IDetailRouter
}

class DetailRouter: IDetailRouter {
    
    var entry: UIViewController?
    
    static func start(with post: Post,
                      andScreenDelegate delegate: PostsScreenDelegate) -> IDetailRouter {
        let router = DetailRouter()
    
        let interactor: IDetailInteractor = DetailInteractor(post: post)
        var presenter: IDetailPresenter = DetailPresenter(interactor: interactor,
                                                          screenDelegate: delegate)
        let controller = DetailMainViewController(presenter: presenter)
    
        presenter.detailView = controller
        presenter.router = router
        router.entry = controller
        
        return router
    }
}
