//
//  ProductsPresenter.swift
//  DWTest
//
//  Created by Denis Windover on 16/02/2024.
//

import Foundation

protocol ProductsPresenterProtocol {
    var products: [Product] { get }
}


class ProductsPresenter: ProductsPresenterProtocol {
    
    weak var view: ProductsViewProtocol?
    
    var products: [Product]
    
    init(for view: ProductsViewProtocol, products: [Product]) {
        self.view = view
        self.products = products
    }
    
}
