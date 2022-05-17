//
//  DetailMainViewController.swift
//  Zemoga
//
//  Created by darius vallejo on 5/14/22.
//

import Foundation
import UIKit

protocol IDetailMainViewController: AnyObject {
    func reloadData()
    func reloadPost(post: Post)
}

class DetailMainViewController: UIViewController, Alertable {
    
    private(set) var presenter: IDetailPresenter
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            setupCells()
        }
    }
    
    init(presenter: IDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: DetailMainViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadModels()
        setupTable()
        setupNavigation(isFavorite: presenter.post.isFavorite ?? false)
        title = "Post"
    }
    
    private func setupNavigation(isFavorite: Bool) {
        let favoriteButton = UIBarButtonItem(image: UIImage(named: isFavorite ?  "favoriteflled": "favorite"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(favoriteAction))
        let removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAction))
        
        navigationItem.rightBarButtonItems = [removeButton, favoriteButton]
    }
    
    private func setupTable() {
        tableView.delegate = presenter.dataSourceDelegate
        tableView.dataSource = presenter.dataSourceDelegate
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    private func setupCells() {
        let nibForUserCell = UINib(nibName: String(describing: UserTableViewCell.self),
                               bundle: nil)
        let nibForCommentCell = UINib(nibName: String(describing: CommentViewCell.self),
                               bundle: nil)
        let nibForPostCell = UINib(nibName: String(describing: PostDetailTableViewCell.self),
                               bundle: nil)
        tableView.register(nibForUserCell,
                               forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        tableView.register(nibForCommentCell,
                               forCellReuseIdentifier: String(describing: CommentViewCell.self))
        tableView.register(nibForPostCell,
                               forCellReuseIdentifier: String(describing: PostDetailTableViewCell.self))
    }
    
    @objc func favoriteAction() {
        presenter.updatePost(isFavorite: !(presenter.post.isFavorite ?? false))
    }
    
    @objc func removeAction() {
        confirmAlert(title: "Remove post", message: "Are you sure you want to permanently remove this item") { [unowned self] _ in
            self.presenter.removePost()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}

extension DetailMainViewController: IDetailMainViewController {
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadPost(post: Post) {
        setupNavigation(isFavorite: post.isFavorite ?? false)
    }
}
