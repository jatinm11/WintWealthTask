//
//  BondDetailDataSource.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondDetailDataSource: NSObject, UICollectionViewDataSource {
    
    var primaryDetails: [DetailObject] = []
    var secondaryDetails: [DetailObject] = []
    
    func setPrimaryDetailsWith(list: [DetailObject]) {
        self.primaryDetails = list
    }
    
    func setSecondaryDetailsWith(list: [DetailObject]) {
        self.secondaryDetails = list
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return primaryDetails.count
        case 1:
            return secondaryDetails.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BondDetailCell", for: indexPath) as! BondDetailCell
            cell.detailObject = primaryDetails[indexPath.item]
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BondDetailCell", for: indexPath) as! BondDetailCell
            cell.detailObject = secondaryDetails[indexPath.item]
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}
