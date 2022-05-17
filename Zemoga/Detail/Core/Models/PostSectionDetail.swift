//
//  PostSectionDetail.swift
//  Zemoga
//
//  Created by darius vallejo on 5/16/22.
//

import Foundation
import UIKit

struct PostSectionDetail: AnySectionWithModel {
    typealias Model = Post?

    var model: Post?
}

extension AnySectionWithModel where Model == Post? {
    func numberOfRowsInSection() -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: String(describing: PostDetailTableViewCell.self),
          for: indexPath) as? PostDetailTableViewCell else {
            return UITableViewCell()
          }

        cell.descriptionLabel.text = model?.body ?? ""
        
        return cell
    }
}
