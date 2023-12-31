//
//  Endpoints.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

enum AllBondsEndpont: Endpoint {
    
    case getBondsFor(page: String)
    case getBondsWith(query: String, page: String)
    case getBondDetailsWith(isin: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "test.api.wintwealth.com"
        }
    }
    
    var path: String {
        switch self {
        case .getBondsFor, .getBondsWith:
            return "/bondsDirectory/bonds"
        case .getBondDetailsWith:
            return "/bondsDirectory/bondDetails/v2"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getBondsFor(let page):
            return [URLQueryItem(name: "page", value: page),
                    URLQueryItem(name: "limit", value: "10")
            ]
            
        case .getBondsWith(let query, let page):
            return [URLQueryItem(name: "page", value: page),
                    URLQueryItem(name: "limit", value: "10"),
                    URLQueryItem(name: "distinct", value: "true"),
                    URLQueryItem(name: "areFilterOptionsPassed", value: "true"),
                    URLQueryItem(name: "issuerName", value: query)
            ]

        case .getBondDetailsWith(let isin):
            return [
                URLQueryItem(name: "isin", value: isin),
            ]
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
