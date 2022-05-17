//
//  AnySectionForComments.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation

extension AnySectionWithModel where Model == [Comment] {
    func tableView(numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: String(describing: CommentViewCell.self),
          for: indexPath) as? CommentViewCell else {
            return UITableViewCell()
          }
        
        let post = model[indexPath.row]
//        cell.titleLabel.text = post?.title ?? ""
        return cell
    }
}
