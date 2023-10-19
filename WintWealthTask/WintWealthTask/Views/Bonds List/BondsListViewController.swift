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
    
    var searchPlaceholderView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        handleViewModelCallback()
    }
    
    func setupViews() {
        self.tableView.register(UINib(nibName: "BondItemCell", bundle: nil), forCellReuseIdentifier: "BondItemCell")
        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        self.tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMoreCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self.dataSource
        self.dataSource.footerCellDelegate = self
        
        self.searchBar.delegate = self
        
        viewModel.fetchBondsList()
    }
    
    func handleViewModelCallback() {
        
        viewModel.updateUI = { [weak self] bondsList, error in
            
            guard let self = self else { return }
            
            if let bondsList = bondsList {
                DispatchQueue.main.async {
                    self.dataSource.setBondsList(list: bondsList)
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.totalResultsLabel.text = self.viewModel.totalResultsLabelText!
                }
            }
            
            if let _ = error {
                DispatchQueue.main.async {
                    self.totalResultsLabel.text = self.viewModel.totalResultsLabelText!
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
            
            self.dataSource.loadMoreIsEnabled = viewModel.showLoadMoreButton! == true
        }
    }
    
    func showPlaceholderView() {
        searchPlaceholderView = UIView(frame: CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.tableView.frame.height))
        searchPlaceholderView!.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.tableView.addSubview(searchPlaceholderView!)
    }
    
    func hidePlaceholderView() {
        if self.searchPlaceholderView != nil {
            self.searchPlaceholderView?.removeFromSuperview()
            self.searchPlaceholderView = nil
        }
        self.view.endEditing(true)
        self.searchBar.showsCancelButton = !self.searchBar.showsCancelButton
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        let selectedIsin = self.dataSource.bondsList[indexPath.row].isin
        self.navigationController?.pushViewController(BondDetailViewController.controller(isin: selectedIsin), animated: true)
    }
}

extension BondsListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.showPlaceholderView()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.totalResultsLabel.text = searchText.count <= 3 ? "Enter more than 3 words 🤔" : "Search for \(searchText)... ⚡️"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.searchTextField.text, query != "" {
            self.totalResultsLabel.text = "Searching for \(query)... ⌛️"
            self.dataSource.clearList()
            self.viewModel.searchBonds(with: query)
            self.hidePlaceholderView()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.clearCurrentQuery()
        self.totalResultsLabel.text = self.viewModel.totalResultsLabelText
        self.searchBar.searchTextField.text = ""
        self.hidePlaceholderView()
    }
}

extension BondsListViewController: FooterCellDelegate {
    func didTapLoadMore() {
        self.viewModel.loadMoreBonds()
    }
}
