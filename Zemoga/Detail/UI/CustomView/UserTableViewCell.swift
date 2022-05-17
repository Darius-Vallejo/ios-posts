//
//  UserTableViewCell.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var suiteLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var geoLatLabel: UILabel!
    @IBOutlet weak var geoLngLabel: UILabel!
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var bsLabel: UILabel!
    @IBOutlet weak var companyCatchPhrase: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var companyHeightLayout: NSLayoutConstraint!
    
    var reloadData: (() -> Void)?
    private var addressViewMoreIsExpanded = false
    private var companyViewMoreIsExpanded = false
    
    @IBAction func addressViewMoreAction(_ sender: UIButton) {
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [unowned self] in
            self.viewMoreButton.setTitle(self.addressViewMoreIsExpanded ? "View more" : "View less",
                     for: .normal)
            self.addressHeightContraint.constant = addressViewMoreIsExpanded ? 21 : 130
            self.layoutIfNeeded()
        }, completion: nil)
        addressViewMoreIsExpanded.toggle()
        reloadData?()
    }
    
    @IBAction func companyViewMoreAction(_ sender: UIButton) {
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [unowned self] in
            self.companyButton.setTitle(self.companyViewMoreIsExpanded ? "View more" : "View less",
                     for: .normal)
            self.companyHeightLayout.constant = companyViewMoreIsExpanded ? 21 : 90
            self.layoutIfNeeded()
        }, completion: nil)
        companyViewMoreIsExpanded.toggle()
        reloadData?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addressContainerView.clipsToBounds = true
    }
}
