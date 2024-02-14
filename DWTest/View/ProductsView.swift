//
//  ProductsView.swift
//  DWTest
//
//  Created by Denis Windover on 15/02/2024.
//

import UIKit


protocol ProductsViewProtocol where Self: UIViewController {
}

class ProductsView: UIViewController, ProductsViewProtocol {
    
    private var presenter: ProductsPresenterProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    func set(presenter: ProductsPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Action
    @IBAction func backDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 8
        let availableWidth = view.frame.width - (padding * 3)
        let widthPerItem = availableWidth / 2
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: widthPerItem, height: 150)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInsetAdjustmentBehavior = .always
 
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ProductsView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.configure(with: self.presenter.products[indexPath.item])
        return cell
    }
    
}
