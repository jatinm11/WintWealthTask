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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var totalResultsLabel: UILabel!
    
    var viewModel: BondsListViewModel = BondsListViewModel()
    var dataSource = BondsListDataSource()
    
    var currentPage = 1
    var searchPlaceholderView: UIView?
    
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
        
        self.searchBar.delegate = self
    }
    
    func fetchBondsFor(page: Int, query: String? = nil) {
        
        viewModel.fetchBondsListFor(page: "\(page)")
        
        if let query = query {
            viewModel.fetchBondsListFor(query: query)
        }
        else {
            viewModel.fetchBondsListFor(page: "\(currentPage)")
        }

        viewModel.updateUI = { [weak self] bondsList, error in
            
            if let bondsList = bondsList {
                DispatchQueue.main.async {
                    
                    self?.dataSource.setBondsList(list: bondsList)
                    
                    if self?.searchPlaceholderView != nil {
                        self?.searchPlaceholderView?.removeFromSuperview()
                        self?.searchPlaceholderView = nil
                    }
                    
                    self?.tableView.reloadData()
                    self?.currentPage += 1
                    self?.activityIndicator.stopAnimating()
                    
                    if bondsList.isEmpty {
                        self?.totalResultsLabel.text = " No results found ☹️"
                    }
                    else {
                        self?.totalResultsLabel.text = "Showing \(bondsList[0].totalBonds ?? 10) bonds 🚀"
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIsin = self.dataSource.bondsList[indexPath.row].isin
        self.navigationController?.pushViewController(BondDetailViewController.controller(isin: selectedIsin), animated: true)
    }
}

extension BondsListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchPlaceholderView = UIView(frame: CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.tableView.frame.height))
        searchPlaceholderView!.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.tableView.addSubview(searchPlaceholderView!)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.totalResultsLabel.text = searchText.count <= 3 ? "Enter more than 3 words 🤔" : "Search for \(searchText)... ⚡️"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.totalResultsLabel.text = "Searching for \(searchBar.searchTextField.text ?? "")... ⌛️"
        self.dataSource.clearList()
        viewModel.fetchBondsListFor(query: searchBar.searchTextField.text ?? "")
        self.view.endEditing(true)
    }
}

extension BondsListViewController: FooterCellDelegate {
    func didTapLoadMore() {
        self.fetchBondsFor(page: self.currentPage)
    }
}
