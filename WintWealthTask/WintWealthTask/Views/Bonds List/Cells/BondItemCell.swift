//
//  BondItemCell.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondItemCell: UITableViewCell {
    
    @IBOutlet weak var issuerNameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var couponValueLabel: UILabel!
    
    var bondItem: Bond? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let bondItem = bondItem {
            self.issuerNameLabel.text = bondItem.issuerName.capitalized
            self.detailLabel.text = "\(bondItem.creditRating ?? "N/A") • \(bondItem.isin) • \(bondItem.maturityDate?.wintFormat() ?? "N/A")"
            self.couponValueLabel.text = "\(bondItem.couponRate ?? "N/A")%"
        }
    }
}
