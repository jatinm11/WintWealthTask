//
//  BondsListViewController.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondsListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: BondsListViewModel = BondsListViewModel()
    var dataSource = BondsListDataSource()
    
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        self.tableView.register(UINib(nibName: "BondItemCell", bundle: nil), forCellReuseIdentifier: "BondItemCell")
        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        self.tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMoreCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self.dataSource
        self.dataSource.footerCellDelegate = self
        
        self.fetchBondsFor(page: self.currentPage)
    }
    
    func fetchBondsFor(page: Int) {
        
        viewModel.fetchBondsListFor(page: "\(page)")
        
        viewModel.updateUI = { [weak self] bondsList, error in
            
            if let bondsList = bondsList {
                DispatchQueue.main.async {
                    self?.dataSource.setBondsList(list: bondsList)
                    self?.tableView.reloadData()
                    self?.currentPage += 1
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIsin = self.dataSource.bondsList[indexPath.row].isin
        self.navigationController?.pushViewController(BondDetailViewController.controller(isin: selectedIsin), animated: true)
    }
}

extension BondsListViewController: FooterCellDelegate {
    func didTapLoadMore() {
        self.fetchBondsFor(page: self.currentPage)
    }
}
