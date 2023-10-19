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
    
    var isButtonEnabled: Bool?  {
        didSet {
            setButtonState()
        }
    }
    
    override func awakeFromNib() {
        loadMoreButton.layer.borderWidth = 1
        loadMoreButton.layer.borderColor = UIColor(named: "ThemeColor")!.cgColor
        loadMoreButton.layer.cornerRadius = 7
    }
    
    func setButtonState() {
        if let isButtonEnabled = isButtonEnabled {
            self.loadMoreButton.setTitle(isButtonEnabled ? "Load More" : "End of list", for: .normal)
            self.loadMoreButton.isEnabled = isButtonEnabled
            self.loadMoreButton.layer.borderColor = isButtonEnabled ? UIColor(named: "ThemeColor")!.cgColor : UIColor.lightGray.cgColor
            self.loadMoreButton.setTitleColor(isButtonEnabled ? UIColor(named: "ThemeColor")! : .lightGray, for: .normal)
        }
    }
    
    @IBAction func loadMoreButtonTapped(_ sender: Any) {
        self.loadMoreButton.isEnabled = false
        self.loadMoreButton.setTitle("Loading...", for: .normal)
        footerCellDelegate.didTapLoadMore()
    }
}
