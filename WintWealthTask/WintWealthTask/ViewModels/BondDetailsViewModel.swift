//
//  BondDetailsViewModel.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

class BondDetailsViewModel {
    
    var updateUI: ((BondDetailResponse?, Error?) -> Void)?
    
    func fetchBondDetailsFor(isin: String) {
        NetworkManager.shared.request(endpoint: AllBondsEndpont.getBondDetailsWith(isin: isin)) { [weak self] (result: Result<BondDetailResponse, Error>) in
            
            switch result {
            case .success(let bondDetailResponse):
                print(bondDetailResponse)
                self?.updateUI?(bondDetailResponse, nil)
                
            case .failure(let error):
                print(error.localizedDescription)
                self?.updateUI?(nil, error)
            }
        }
    }
}
