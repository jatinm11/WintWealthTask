//
//  BondDetailCell.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondDetailCell: UICollectionViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var detailObject: DetailObject? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let detailObject = detailObject {
            self.keyLabel.text = detailObject.key
            
            if let value = detailObject.value {
                if let doubleValue = Double(value) {
                    self.valueLabel.text = "₹\(doubleValue.withCommas())"
                }
                else {
                    self.valueLabel.text = value
                }
            }
            else {
                self.valueLabel.text = "N/A"
            }
        }
    }
}
