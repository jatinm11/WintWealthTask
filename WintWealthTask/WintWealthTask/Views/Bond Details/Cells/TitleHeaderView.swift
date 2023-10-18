//
//  TitleHeaderView.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class TitleHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
