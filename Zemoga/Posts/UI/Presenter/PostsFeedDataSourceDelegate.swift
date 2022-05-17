//
//  PostsFeedDataSourceDelegate.swift
//  Zemoga
//
//  Created by darius vallejo on 5/13/22.
//

import Foundation
import UIKit

typealias TableViewDataDelegate =  UITableViewDataSource & UITableViewDelegate

class PostsFeedDataSourceDelegate: NSObject, TableViewDataDelegate {
    
    private(set) weak var dataDelegate: PostsDataManager?
    
    init(dataDelegate: PostsDataManager) {
        self.dataDelegate = dataDelegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDelegate?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: String(describing: PostTableViewCell.self),
          for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
          }
        
        let post = dataDelegate?.posts[indexPath.row]
        cell.titleLabel.text = post?.title ?? ""
        cell.favoriteImageView.image = UIImage(named: (post?.isFavorite ?? false)
                                               ?  "favoriteflled"
                                               : "favorite")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = dataDelegate?.posts[indexPath.row] else {
            return
        }
        dataDelegate?.loadDetail(by: post)
    }
    
}
