//
//  FAQCell.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

protocol FAQCellDelegate {
    func didTapViewFor(index: IndexPath, cell: FAQCell)
}

class FAQCell: UITableViewCell {

    @IBOutlet weak var faqKeyView: UIView!
    @IBOutlet weak var faqKeyLabel: UILabel!
    
    @IBOutlet weak var faqValueView: UIView!
    @IBOutlet weak var faqValueLabel: UILabel!
    
    @IBOutlet weak var chevronImageView: UIImageView!
    
    var faqItemObject: DetailObject? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: FAQCellDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews() {
        if let faqItemObject = faqItemObject {
            self.faqKeyLabel.text = faqItemObject.key
            self.faqValueLabel.text = faqItemObject.value ?? "N/A"
        }
    }
}
