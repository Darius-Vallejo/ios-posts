//
//  UserSectionDetail.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation
import UIKit

protocol TableViewCellUpdater {
    func reloadData()
}

struct UserSectionDetail: AnySectionWithModel {
    typealias Model = User?

    var model: User?
}

extension AnySectionWithModel where Model == User? {
    func numberOfRowsInSection() -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: String(describing: UserTableViewCell.self),
          for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
          }

        cell.nameLabel.text = model?.name ?? ""
        cell.usernameLabel.text = model?.username ?? ""
        cell.emailLabel.text = model?.email ?? ""
        cell.addressLabel.text = model?.address.street ?? ""
        cell.suiteLabel.text = model?.address.suite ?? ""
        cell.cityLabel.text = model?.address.city ?? ""
        cell.zipCodeLabel.text = model?.address.zipcode ?? ""
        cell.geoLatLabel.text = model?.address.geo.lat ?? ""
        cell.geoLngLabel.text = model?.address.geo.lng ?? ""
        cell.phoneLabel.text = model?.phone ?? ""
        cell.websiteLabel.text = model?.website ?? ""
        cell.companyNameLabel.text = model?.company.name ?? ""
        cell.companyCatchPhrase.text = model?.company.catchPhrase ?? ""
        cell.bsLabel.text = model?.company.bs ?? ""
        
        cell.reloadData = {
            tableView.reloadData()
        }
        return cell
    }
    
    func reloadData() {
        
    }
}
