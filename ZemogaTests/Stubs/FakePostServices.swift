//
//  FakePostServices.swift
//  ZemogaTests
//
//  Created by darius vallejo on 5/16/22.
//

import Foundation
import Combine
@testable import Zemoga

class FakePostsServices: IPostServices {
    func posts() -> AnyPublisher<[Post], NetworkErrors> {
        let subject = CurrentValueSubject<[Post], NetworkErrors>([Post(id: 1, userId: 1, title: "", body: ""), Post(id: 2, userId: 2, title: "", body: "")])
        return subject.eraseToAnyPublisher()
    }
    
    func comments(by postId: Int) -> AnyPublisher<[Comment], NetworkErrors> {
        let subject = CurrentValueSubject<[Comment], NetworkErrors>([Comment(postId: 1, id: 1, name: "", email: "", body: ""), Comment(postId: 2, id: 2, name: "", email: "", body: "")])
        return subject.eraseToAnyPublisher()
    }
    
    func user(userId: Int) -> AnyPublisher<[User], NetworkErrors> {
        let address = Address(street: "", suite: "", city: "", zipcode: "", geo: .init(lat: "", lng: ""))
        let company = Company(name: "", catchPhrase: "", bs: "")
        let subject = CurrentValueSubject<[User], NetworkErrors>([User(id: 1, name: "", username: "", email: "", address: address, phone: "", website: "", company: company) ])
        return subject.eraseToAnyPublisher()
    }
}
