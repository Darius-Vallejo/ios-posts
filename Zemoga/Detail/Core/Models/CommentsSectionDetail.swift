//
//  AnySectionForComments.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation
import UIKit

struct CommentsSectionDetail: AnySectionWithModel {
    typealias Model = [Comment]

    var model: [Comment]
}

extension AnySectionWithModel where Model == [Comment] {
    func numberOfRowsInSection() -> Int {
        return model.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: String(describing: CommentViewCell.self),
          for: indexPath) as? CommentViewCell else {
            return UITableViewCell()
          }

        let comment = model[indexPath.row]
        cell.nameLabel.text = comment.name.capitalized
        cell.emailLabel.text = comment.email.lowercased()
        cell.bodyLabel.text = comment.body
        
        return cell
    }
}
