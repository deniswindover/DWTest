//
//  ProductEndpoint.swift
//  DWTest
//
//  Created by Denis Windover on 15/02/2024.
//

import Foundation

enum ProductEndpoint {
    case fetchProducts(limit: Int?)
}


extension ProductEndpoint: Endpoint {
    
    var baseURL: String {
        return "https://dummyjson.com/"
    }
    
    var path: String {
        switch self {
        case .fetchProducts(let limit):
            return "products?limit=\(limit ?? 100)"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : Any]? {
        return nil
    }
    
}
