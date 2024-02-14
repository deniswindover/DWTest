//
//  Category.swift
//  DWTest
//
//  Created by Denis Windover on 16/02/2024.
//

import Foundation

struct Category {
    var name: String
    var products: [Product]
    
    var thumb: URL? {
        return URL(string: products.first?.thumbnail ?? "")
    }
    
    var stock: Int {
        return products.reduce(into: 0) { $0 += ($1.stock ?? 0) }
    }

}
