//
//  PostsInteractorTests.swift
//  ZemogaTests
//
//  Created by darius vallejo on 5/16/22.
//

import XCTest
import Combine
@testable import Zemoga

class PostsInteractorTests: XCTestCase {
    
    var interactor: PostsInteractor!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        interactor = PostsInteractor(services: FakePostsServices())
    }
    
    func testPosts_withoutLoadPosts_postsAreNotLoaded() {
        let posts = interactor.posts
        XCTAssertEqual(posts, [])
    }
    
    func testPosts_callingLoadPosts_postsAreLoaded() {
        let expec = expectation(description: "Calling load Posts")
        var cancellable: AnyCancellable?
        cancellable = interactor
            .postsPublisher
            .replaceError(with: .newPostsLoaded([]))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                if case let .newPostsLoaded(posts) = $0, !posts.isEmpty {
                    expec.fulfill()
                    cancellable?.cancel()
                }
            })

        interactor.loadPosts()
        waitForExpectations(timeout: 5, handler: nil)
        let posts = interactor.posts
        XCTAssertEqual(posts.count, 2)
    }
    
    func testListUpdater_updatingCurrentList_likedPostsIsUpdated() {
        interactor.loadPosts()
        var postUpdated = interactor.posts[0]
        postUpdated.isFavorite = true
        let expec = expectation(description: "Calling Posts updater")
        var cancellable: AnyCancellable?
        cancellable = interactor
            .postsPublisher
            .replaceError(with: .newPostsLoaded([]))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                if case let .newPostsLoaded(posts) = $0, !posts.isEmpty {
                    expec.fulfill()
                    cancellable?.cancel()
                }
            })

        interactor.updateCurrentList(by: postUpdated)
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(interactor.posts[0].isFavorite ?? false)
    }
    
    func testListRemover_removeSpecificPost_postRemoved() {
        interactor.loadPosts()
        let postToRemove = interactor.posts[0]
        let expec = expectation(description: "Calling Posts updater")
        var cancellable: AnyCancellable?
        cancellable = interactor
            .postsPublisher
            .replaceError(with: .newPostsLoaded([]))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                if case let .newPostsLoaded(posts) = $0, !posts.isEmpty {
                    expec.fulfill()
                    cancellable?.cancel()
                }
            })

        interactor.removePostFromList(post: postToRemove)
        waitForExpectations(timeout: 3, handler: nil)
        let postFound = interactor.posts.first(where: {
            return $0 == postToRemove
        })
        XCTAssertNil(postFound)
    }
    
    func testListRemover_removeall_postListIsEmpty() {
        interactor.loadPosts()
        let expec = expectation(description: "Calling Posts remover")
        var cancellable: AnyCancellable?
        cancellable = interactor
            .postsPublisher
            .replaceError(with: .newPostsLoaded([]))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                if case .newPostsLoaded = $0 {
                    expec.fulfill()
                    cancellable?.cancel()
                }
            })

        interactor.removeAll()
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(interactor.posts.isEmpty)
    }
    
}
