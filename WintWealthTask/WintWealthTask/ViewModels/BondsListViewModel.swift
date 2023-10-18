//
//  BondsListViewModel.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

class BondsListViewModel {
    
    var updateUI: (([Bond]?, Error?) -> Void)?
    
    func fetchBondsListFor(page: String) {
        NetworkManager.shared.request(endpoint: AllBondsEndpont.getBondsFor(page: page, limit: "10")) { [weak self] (result: Result<[Bond], Error>) in
            
            print(AllBondsEndpont.getBondsFor(page: page, limit: "10"))
            
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
