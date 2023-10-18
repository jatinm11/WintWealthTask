//
//  FooterCell.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

protocol FooterCellDelegate {
    func didTapLoadMore()
}

class LoadMoreCell: UITableViewCell {
    
    @IBOutlet weak var loadMoreButton: UIButton!
    
    var footerCellDelegate: FooterCellDelegate!
    
    override func awakeFromNib() {
        loadMoreButton.layer.borderWidth = 1
        loadMoreButton.layer.borderColor = UIColor(red: 53/255.0, green: 105/255.0, blue: 53/255.0, alpha: 1).cgColor
        loadMoreButton.layer.cornerRadius = 7
    }
    
    @IBAction func loadMoreButtonTapped(_ sender: Any) {
        footerCellDelegate.didTapLoadMore()
    }
}
