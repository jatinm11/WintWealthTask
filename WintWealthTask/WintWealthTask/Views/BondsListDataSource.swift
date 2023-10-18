//
//  BondsListDataSource.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondsListDataSource: NSObject, UITableViewDataSource {
    
    var bondsList: [Bond] = []
    
    func setBondsList(list: [Bond]) {
        self.bondsList.append(contentsOf: list)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : bondsList.count
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

        default:
            return UITableViewCell()
        }
    }
}
