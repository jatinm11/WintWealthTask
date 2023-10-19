//
//  Extensions.swift
//  WintWealthTask
//
//  Created by Jatin Menghani on 18/10/23.
//

import Foundation

extension String {
    
    var serverFormat: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter.date(from: self)!
    }
    
    func wintFormat() -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: serverFormat)
    }
}

extension Double {
    func withCommas() -> String {
        let numberFomatter = NumberFormatter()
        numberFomatter.numberStyle = .decimal
        numberFomatter.locale = Locale(identifier: "en_IN")
        return numberFomatter.string(from: NSNumber(value: self)) ?? "0.0"
    }
}
