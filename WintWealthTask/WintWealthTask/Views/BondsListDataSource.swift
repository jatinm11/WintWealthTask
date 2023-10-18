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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bondsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bondListCell = tableView.dequeueReusableCell(withIdentifier: "BondItemCell", for: indexPath) as! BondItemCell
        bondListCell.bondItem = self.bondsList[indexPath.row]
        return bondListCell
    }
}
