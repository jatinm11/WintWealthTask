//
//  BondItemCell.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondItemCell: UITableViewCell {
    
    @IBOutlet weak var issuerNameLabel: UILabel!
    @IBOutlet weak var couponValueLabel: UILabel!
    
    var bondItem: Bond? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let bondItem = bondItem {
            self.issuerNameLabel.text = bondItem.issuerName
            self.couponValueLabel.text = bondItem.couponRate
        }
    }
}
