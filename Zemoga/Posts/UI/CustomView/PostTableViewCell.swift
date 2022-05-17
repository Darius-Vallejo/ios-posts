//
//  PostCellTableView.swift
//  Zemoga
//
//  Created by darius vallejo on 5/13/22.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
