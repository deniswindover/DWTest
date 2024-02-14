//
//  ProductService.swift
//  DWTest
//
//  Created by Denis Windover on 15/02/2024.
//

import Foundation

protocol ProductServiceable {
    func fetchProducts(with limit: Int?) async -> Result<ProductData?, RequestError>
}

struct ProductService: HTTPClient, ProductServiceable {
    func fetchProducts(with limit: Int?) async -> Result<ProductData?, RequestError> {
        return await request(endpoint: ProductEndpoint.fetchProducts(limit: limit), responseModel: ProductData.self)
    }
    
}
