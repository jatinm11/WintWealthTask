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
    
    var isExpanded: Bool = false {
        didSet {
            faqValueView.isHidden = !isExpanded
            chevronImageView.image = UIImage(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
    }
    
    var delegate: FAQCellDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupGesture()
        
        self.faqValueView.isHidden = true
    }
    
    func setupGesture() {        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleValueView(_:)))
        tapGesture.numberOfTapsRequired = 1
        faqKeyView.addGestureRecognizer(tapGesture)
        faqKeyView.isUserInteractionEnabled = true
    }

    @objc func toggleValueView(_ sender: UITapGestureRecognizer) {
        isExpanded = !isExpanded
        delegate.didTapViewFor(index: self.indexPath, cell: self)
    }
    
    func updateViews() {
        if let faqItemObject = faqItemObject {
            self.faqKeyLabel.text = faqItemObject.key
            self.faqValueLabel.text = faqItemObject.value ?? "N/A"
        }
    }
}
