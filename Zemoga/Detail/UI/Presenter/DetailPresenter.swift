//
//  DetailPresenter.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation
import Combine
import UIKit

protocol DetailDataManager: AnyObject {
    var sections: [AnySection] { get }
}

protocol IDetailPresenter {
    var router: IDetailRouter? { get set }
    var detailView: IDetailMainViewController? { get set }
    var dataSourceDelegate: TableViewDataDelegate { get }
    var post: Post { get }
    
    func loadModels()
    func updatePost(isFavorite: Bool)
    func removePost()
}

class DetailPresenter: IDetailPresenter {
    
    private var interactor: IDetailInteractor
    private var cancellables: Set<AnyCancellable> = []
    weak var detailView: IDetailMainViewController?
    weak var screenDelegate: PostsScreenDelegate?
    var router: IDetailRouter?
    lazy var dataSourceDelegate: TableViewDataDelegate = {
        DetailFeedDataSourceDelegate(dataDelegate: self)
    }()
    
    var post: Post {
        return interactor.post
    }
    
    init(interactor: IDetailInteractor, screenDelegate: PostsScreenDelegate) {
        self.interactor = interactor
        self.screenDelegate = screenDelegate
        interactor
            .dataManagerPublisher
            .replaceError(with: .newComentsLoaded([]))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] in
                self.updateContent(by: $0)
            })
            .store(in: &cancellables)
    }
    
    private func updateContent(by updater: PostsUpdater) {
        switch updater {
        case .newComentsLoaded, .newUserLoaded:
            detailView?.reloadData()
        case .updatePost(let post):
            screenDelegate?.update(post: post)
            detailView?.reloadPost(post: post)
        default:
            break
        }
    }
    
    func loadModels() {
        interactor.loadModels()
    }
    
    func updatePost(isFavorite: Bool) {
        interactor.update(when: isFavorite)
    }
    
    func removePost() {
        screenDelegate?.remove(post: interactor.post)
    }
    
}

extension DetailPresenter: DetailDataManager {
    var sections: [AnySection] {
        return [PostSectionDetail(model: interactor.post),
                UserSectionDetail(model: interactor.user),
                CommentsSectionDetail(model: interactor.comments)]
    }
}
