//
//  DetailFeedDataSourceDelegate.swift
//  Zemoga
//
//  Created by darius vallejo on 5/15/22.
//

import Foundation
import UIKit

class DetailFeedDataSourceDelegate: NSObject, TableViewDataDelegate {
    
    private(set) weak var dataDelegate: DetailDataManager?
    
    init(dataDelegate: DetailDataManager) {
        self.dataDelegate = dataDelegate
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataDelegate?.sections.count ?? 0
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDelegate?.sections[section].numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataDelegate?
            .sections[indexPath.section]
            .tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Description"
        } else if section == 1 {
            return "User"
        }
        
        return "COMMENTS"
    }
    
}
