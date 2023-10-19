//
//  BondDetail.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

struct BondDetailResponse: Codable {
    let isin: String
    let issuerName: String

    let primaryDetails: [DetailObject]
    let secondaryDetails: [DetailObject]
    
    let faqs: [DetailObject]
}

struct DetailObject: Codable {
    let key: String
    let value: String?
}

struct FAQObject {
    var faqItem: DetailObject
    var isExpanded: Bool
}
