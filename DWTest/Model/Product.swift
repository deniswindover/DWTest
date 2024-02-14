//
//  Product.swift
//  DWTest
//
//  Created by Denis Windover on 15/02/2024.
//

import Foundation

// MARK: - ProductData
struct ProductData: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
    
    var thumb: URL? {
        return URL(string: thumbnail ?? "")
    }
    
    static func saveProducts(_ products: [Product]) {
        let encoder = JSONEncoder()
        if let encodedProducts = try? encoder.encode(products) {
            UserDefaults.standard.set(encodedProducts, forKey: "products")
        }
    }
    
    static func loadProducts() -> [Product] {
        if let savedProducts = UserDefaults.standard.object(forKey: "products") as? Data {
            let decoder = JSONDecoder()
            if let loadedProducts = try? decoder.decode([Product].self, from: savedProducts) {
                return loadedProducts
            }
        }
        return []
    }

    
}
