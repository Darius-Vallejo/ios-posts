//
//  PostsInteractor.swift
//  Zemoga
//
//  Created by darius vallejo on 5/11/22.
//

import Foundation


protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
}

class PostsInteractor: AnyInteractor {
        var presenter: AnyPresenter?

}
