//
//  SKProduct-LocalizedPrice.swift
//  SKProduct-LocalizedPrice
//
//  Created by Andrei Chenchik on 19/7/21.
//

import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
