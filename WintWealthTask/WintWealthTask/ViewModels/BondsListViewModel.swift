//
//  BondsListViewModel.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

class BondsListViewModel {
    
    var updateUI: (([Bond]?, Error?) -> Void)?
    
    private var currentPage = 1
    private var currentQuery: String?
    
    var totalResultsLabelText: String?
    
    func fetchBondsList(page: Int? = 1, query: String? = nil) {
        var endPoint: AllBondsEndpont!
        if let query = query {
            endPoint = AllBondsEndpont.getBondsWith(query: query, page: "\(currentPage)")
        }
        else {
            endPoint = AllBondsEndpont.getBondsFor(page: "\(currentPage)")
        }
        
        NetworkManager.shared.request(endpoint: endPoint) { [weak self] (result: Result<[Bond], Error>) in
            switch result {
            case .success(let bondsList):
                if !bondsList.isEmpty {
                    self?.updateUI?(bondsList, nil)
                    self?.currentPage += 1
                    self?.totalResultsLabelText = "Showing \(bondsList[0].totalBonds ?? 10) bonds 🚀"
                }
                else {
                    var errorDescription = ""
                    if self?.currentQuery != nil {
                        errorDescription = "No results found ☹️"
                    }
                    else {
                        errorDescription = "Unable to load bonds at the moment ☹️"
                    }
                    
                    self?.totalResultsLabelText = errorDescription
                    self?.updateUI?(nil, NSError(domain: "", code: 404))
                }
                
            case .failure(let error):
                self?.totalResultsLabelText = "Unable to load bonds at the moment ☹️"
                self?.updateUI?(nil, error)
            }
        }
    }
    
    func searchBonds(with query: String) {
        self.currentPage = 1
        currentQuery = query
        fetchBondsList(page: currentPage, query: query)
    }
    
    func loadMoreBonds() {
        if let query = self.currentQuery {
            fetchBondsList(page: currentPage, query: query)
        }
        else {
            fetchBondsList(page: currentPage)
        }
    }
    
    func clearCurrentQuery() {
        self.currentQuery = nil
    }
}
