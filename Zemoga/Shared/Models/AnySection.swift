//
//  AnySection.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation
import UIKit

protocol AnySection {
    func numberOfRowsInSection() -> Int
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol AnySectionWithModel: AnySection {
    associatedtype Model
    
    var model: Model { get }
}
