//
//  BondDetailDataSource.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let titleHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TitleHeaderView", for: indexPath) as! TitleHeaderView
            titleHeaderView.titleLabel.text = "Bond Key Highlights"
            return titleHeaderView
        default:
            return UICollectionReusableView()
        }
    }
}


class BondDetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    var faqDetails: [DetailObject] = []
    var delegate: FAQCellDelegate!
    
    func setFaqDetailsWith(list: [DetailObject]) {
        self.faqDetails = list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
        cell.faqItemObject = faqDetails[indexPath.row]
        cell.delegate = delegate
        cell.indexPath = indexPath
                
        return cell
    }
}
