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
            titleHeaderView.titleLabel.text = self.secondaryDetails.count > 0 ? "Bond Key Highlights" : ""
            return titleHeaderView
        default:
            return UICollectionReusableView()
        }
    }
}


class BondDetailTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var faqObjects: [FAQObject] = []
    
    var delegate: FAQCellDelegate!
    
    func setFaqObjectsWith(list: [FAQObject]) {
        self.faqObjects = list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
        
        cell.faqItemObject = faqObjects[indexPath.row].faqItem
        cell.delegate = delegate
        cell.indexPath = indexPath
        
        cell.faqValueView.isHidden = !faqObjects[indexPath.row].isExpanded
        cell.chevronImageView.image = UIImage(systemName: faqObjects[indexPath.row].isExpanded ? "chevron.up" : "chevron.down")
        
        return cell
    }
}
