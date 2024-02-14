//
//  CategoryCell.swift
//  DWTest
//
//  Created by Denis Windover on 16/02/2024.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var productsCount: UILabel!
    @IBOutlet weak var stock: UILabel!
    
    func configure(with category: Category) {
        
        self.name.text = category.name
        self.productsCount.text = category.products.count.formatted()
        self.stock.text = category.stock.formatted()
        
        let processor = DownsamplingImageProcessor(size: thumb.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        thumb.kf.indicatorType = .activity
        thumb.kf.setImage(
            with: category.thumb,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { result in }
        
        
    }
    
}
