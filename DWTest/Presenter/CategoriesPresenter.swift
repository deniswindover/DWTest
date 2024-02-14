//
//  CategoriesPresenter.swift
//  DWTest
//
//  Created by Denis Windover on 16/02/2024.
//

import Foundation
import UIKit


protocol CategoriesPresenterProtocol {
    var categories: [Category] { get }
    func categoryDidSelect(indexPath: IndexPath)
}


class CategoriesPresenter: CategoriesPresenterProtocol {
    
    weak var view: CategoriesViewProtocol?
    
    var categories: [Category] = [] {
        didSet {
            view?.reloadUI()
        }
    }
    
    private var products: [Product] = [] {
        didSet {
            sortProducts()
        }
    }
    
    init(for view: CategoriesViewProtocol) {
        self.view = view
        configureDatasource()
    }
    
    // MARK: - CategoriesPresenterProtocol
    func categoryDidSelect(indexPath: IndexPath) {
        self.showProducts(for: categories[indexPath.item])
    }
    
    // MARK: - Private
    private func configureDatasource() {
        
        self.products = Product.loadProducts()
        self.fetchDatasource()
        
    }
    
    private func fetchDatasource() {
        
        Task(priority: .background) {
            
            let service = ProductService()
            let result = await service.fetchProducts(with: 100)
            
            switch result {
            case .success(let productData):
                
                if let productData = productData {
                    self.products = productData.products
                    Product.saveProducts(productData.products)
                }
                
            case .failure(let error):
                debugPrint(error)
            }
            
        }
        
    }
    
    private func sortProducts() {
        
        self.categories = Dictionary(grouping: products, by: { $0.category ?? "" })
            .map { Category(name: $0.key, products: $0.value) }
            .sorted { $0.name < $1.name }
        
    }
    
    private func showProducts(for category: Category) {
        
        let productsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsView") as! ProductsView
        let presenter = ProductsPresenter(for: productsVC, products: category.products)
        productsVC.title = category.name
        productsVC.set(presenter: presenter)

        view?.navigationController?.pushViewController(productsVC, animated: true)
    }
    
}
