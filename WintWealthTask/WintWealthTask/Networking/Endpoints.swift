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
    
    case getBondsFor(page: String, limit: String)
    
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
        default:
            return "/bondsDirectory/bonds"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getBondsFor(let page, let limit):
            return [URLQueryItem(name: "page", value: page),
                    URLQueryItem(name: "limit", value: limit)
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
