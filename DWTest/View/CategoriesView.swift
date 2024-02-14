//
//  CategoriesView.swift
//  DWTest
//
//  Created by Denis Windover on 15/02/2024.
//

import UIKit

protocol CategoriesViewProtocol where Self: UIViewController {
    func reloadUI()
}


class CategoriesView: UIViewController, CategoriesViewProtocol {
    
    private var presenter: CategoriesPresenterProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = CategoriesPresenter(for: self)
        
        self.setupCollectionView()
        
    }
    
    // MARK: - CategoriesViewProtocol
    func reloadUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
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
extension CategoriesView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configure(with: self.presenter.categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.categoryDidSelect(indexPath: indexPath)
    }
    
}
