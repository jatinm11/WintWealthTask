//
//  BondsListViewController.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import UIKit

class BondsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: BondsListViewModel = BondsListViewModel()
    var dataSource = BondsListDataSource()
    
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "BondItemCell", bundle: nil), forCellReuseIdentifier: "BondItemCell")
        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")

        fetchBondsFor(page: self.currentPage)
    }
    
    func fetchBondsFor(page: Int) {
        
        viewModel.fetchBondsListFor(page: "\(page)")
        
        viewModel.updateUI = { [weak self] bondsList, error in
            if let bondsList = bondsList {
                DispatchQueue.main.async {
                    self?.dataSource.setBondsList(list: bondsList)
                    self?.tableView.reloadData()
                    self?.currentPage += 1
                }
            }
        }
    }
}

extension BondsListViewController: UITableViewDelegate {
    
}
