//
//  BondDetailViewController.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = BondDetailsViewModel()
    var bondDetailsdataSource = BondDetailDataSource()
    
    var isin: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "BondDetailCell", bundle: nil), forCellWithReuseIdentifier: "BondDetailCell")
        self.collectionView.register(UINib(nibName: "TitleHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"TitleHeaderView")
     
        viewModel.fetchBondDetailsFor(isin: self.isin)
        viewModel.updateUI = { [weak self] bondDetailsResponse, error in
            
            if let bondDetailsResponse = bondDetailsResponse {
                DispatchQueue.main.async {
                    self?.bondDetailsdataSource.setPrimaryDetailsWith(list: bondDetailsResponse.primaryDetails)
                    self?.bondDetailsdataSource.setSecondaryDetailsWith(list: bondDetailsResponse.secondaryDetails)
                    self?.collectionView.reloadData()
                }
            }
        }
        
        self.collectionView.dataSource = self.bondDetailsdataSource
        self.collectionView.delegate = self
    }
    
    static func controller(isin: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BondDetailViewController") as! BondDetailViewController
        vc.isin = isin
        return vc
    }
}

// MARK: Flow Layout
extension BondDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 20) / 2
        return CGSize(width: itemWidth, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: 0, height: 0) : CGSize(width: collectionView.bounds.width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 50, right: 0)
    }
}
