//
//  BondsListViewModel.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

class BondsListViewModel {
    
    var updateUI: (([Bond]?, Error?) -> Void)?
    
    func fetchBondsListFor(page: String? = nil, query: String? = nil) {
        
        var endPoint: AllBondsEndpont?
        
        if let query = query {
            endPoint = AllBondsEndpont.getBondsWith(query: query)
        }
        else {
            endPoint = AllBondsEndpont.getBondsFor(page: page!, limit: "10")
        }
        
        NetworkManager.shared.request(endpoint: endPoint!) { [weak self] (result: Result<[Bond], Error>) in
            
            switch result {
            case .success(let bondsList):
                print(bondsList)
                self?.updateUI?(bondsList, nil)
                print(bondsList)
                
            case .failure(let error):
                self?.updateUI?(nil, error)
            }
        }
    }
}
