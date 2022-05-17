//
//  CommentViewCell.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation
import UIKit

class CommentViewCell: UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
