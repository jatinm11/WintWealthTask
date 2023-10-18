//
//  BondsListDataSource.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondsListDataSource: NSObject, UITableViewDataSource {
    
    var footerCellDelegate: FooterCellDelegate!
    
    var bondsList: [Bond] = []
    
    func setBondsList(list: [Bond]) {
        self.bondsList.append(contentsOf: list)
    }
    
    func clearList() {
        self.bondsList = []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,2:
            return self.bondsList.count > 0 ? 1 : 0
        case 1:
            return self.bondsList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            return headerCell
            
        case 1:
            let bondListCell = tableView.dequeueReusableCell(withIdentifier: "BondItemCell", for: indexPath) as! BondItemCell
            bondListCell.bondItem = self.bondsList[indexPath.row]
            return bondListCell
            
        case 2:
            let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell") as! LoadMoreCell
            loadMoreCell.footerCellDelegate = footerCellDelegate
            return loadMoreCell
            
        default:
            return UITableViewCell()
        }
    }
}
