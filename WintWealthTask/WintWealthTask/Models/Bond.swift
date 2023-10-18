//
//  Bond.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

struct Bond: Codable {
    
    var totalBonds: Int?
    
    var isin: String
    
    var issuerName: String
    
    var issueMode: String?
    
    var faceValue: Int?
    
    var issueSize: String?
    
    var timeLeftForMaturity: String?
    
    var maturityDate: String?
    
    var couponRate: String?
    
    var couponType: String?
    
    var interestRepayment: String?
    
    var creditRating: String?
    
    var businessSector: String?
    
    var instrumentStatus: String?
    
    var issuerNameSlug: String?
    
}
