//
//  Services.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation
import Combine

protocol AnyService {
    func session<Model>(url: String, type: Model.Type) -> AnyPublisher<Model, NetworkErrors> where Model: Decodable
}

extension AnyService {
    func session<Model>(url: String, type: Model.Type) -> AnyPublisher<Model, NetworkErrors> where Model: Decodable {
        let urlForSession = URL(string: url)!
        
        return URLSession
           .shared
           .dataTaskPublisher(for: urlForSession)
           .tryMap(\.data)
           .decode(type: type, decoder: JSONDecoder())
           .mapError { error -> NetworkErrors in
               print(error)
               switch error {
               case is URLError:
                   return .badContent
               case is DecodingError:
                   return .decode
               default:
                   return .unknown
               }
           }.eraseToAnyPublisher()
    }
}

struct Services: AnyService {
    
    static var instance: Services = {
        return Services()
    }()
    
    func posts() -> AnyPublisher<[Post], NetworkErrors> {
        return session(url: ServicesDefinitions.posts, type: [Post].self)
    }
}
