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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func fetchBondsDetailsWith(isin: String) {
        viewModel.fetchBondDetailsFor(isin: isin)
        
    }
    
    static func controller(isin: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BondDetailViewController") as! BondDetailViewController
        vc.isin = isin
        return vc
    }
}

extension BondDetailViewController: UICollectionViewDelegateFlowLayout {
    
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
}
