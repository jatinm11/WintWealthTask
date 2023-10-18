//
//  BondDetailViewController.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel = BondDetailsViewModel()
    var bondDetailCollectionViewDataSource = BondDetailCollectionViewDataSource()
    var bondDetailTableViewDataSource = BondDetailTableViewDataSource()
    
    var expandedIndexPaths: [IndexPath] = []
    
    var isin: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupCollectionView()
        setupTableView()
        setupViews()
    }
    
    func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "TitleHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"TitleHeaderView")
        self.collectionView.register(UINib(nibName: "BondDetailCell", bundle: nil), forCellWithReuseIdentifier: "BondDetailCell")
        
        self.collectionView.dataSource = self.bondDetailCollectionViewDataSource
        self.collectionView.delegate = self
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        self.tableView.dataSource = self.bondDetailTableViewDataSource
        
        self.bondDetailTableViewDataSource.delegate = self
    }
    
    func setupViews() {
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        viewModel.fetchBondDetailsFor(isin: self.isin)
        
        viewModel.updateUI = { [weak self] bondDetailsResponse, error in
            if let bondDetailsResponse = bondDetailsResponse {
                DispatchQueue.main.async {
                    self?.bondDetailCollectionViewDataSource.setPrimaryDetailsWith(list: bondDetailsResponse.primaryDetails)
                    self?.bondDetailCollectionViewDataSource.setSecondaryDetailsWith(list: bondDetailsResponse.secondaryDetails)
                    self?.collectionViewHeightConstraint.constant = CGFloat((bondDetailsResponse.primaryDetails.count + bondDetailsResponse.secondaryDetails.count) * 50 - 25)
                    self?.collectionView.reloadData()
                    
                    self?.bondDetailTableViewDataSource.setFaqDetailsWith(list: bondDetailsResponse.faqs)
                    self?.tableViewHeightConstraint.constant = CGFloat(bondDetailsResponse.faqs.count * 70)
                    self?.tableView.reloadData()
                }
            }
        }
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
        return CGSize(width: (collectionView.frame.width - 20) / 2, height: 50)
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
        return UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
    }
}

extension BondDetailViewController: FAQCellDelegate {
    func didTapViewFor(index: IndexPath, cell: FAQCell) {
        self.tableView.reloadRows(at: [index], with: .none)
    }
}
