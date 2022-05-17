//
//  PostsMainViewController.swift
//  Zemoga
//
//  Created by darius vallejo on 5/11/22.
//

import Foundation
import UIKit
import Combine

protocol IPostsMainViewController: AnyObject {
    func reloadData()
}

class PostsMainViewController: UIViewController, Alertable {
    
    private(set) var presenter: IPostsPresenter
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet private weak var postTableView: UITableView! {
        didSet {
            let nibForCell = UINib(nibName: String(describing: PostTableViewCell.self),
                                   bundle: nil)
            postTableView.register(nibForCell,
                                   forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        }
    }
    
    init(presenter: IPostsPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: PostsMainViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadPosts()
        setupTable()
        title = "Posts"
        deleteAllButton.layer.cornerRadius = 5
        deleteAllButton.layer.masksToBounds = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupTable() {
        postTableView.dataSource = presenter.dataSourceDelegate
        postTableView.delegate = presenter.dataSourceDelegate
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.estimatedRowHeight = 600
        postTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadPostList), for: .valueChanged)
        refreshControl.tintColor = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching posts data", attributes: nil)
    }
    
    @IBAction func removeAction() {
        confirmAlert(title: "Remove posts",
                     message: "Are you sure you want to permanently remove all items") { [unowned self] _  in
            self.presenter.removeAll()
        }
    }
    
    @objc private func reloadPostList() {
        self.presenter.loadPosts()
    }
    
}

extension PostsMainViewController: IPostsMainViewController {
    func reloadData() {
        refreshControl.endRefreshing()
        postTableView.reloadData()
    }
}
