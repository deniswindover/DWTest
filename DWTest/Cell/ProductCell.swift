//
//  ProductCell.swift
//  DWTest
//
//  Created by Denis Windover on 16/02/2024.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stock: UILabel!
    
    
    func configure(with product: Product) {
        
        self.configurePrice(price: Double(product.price ?? 0), discount: product.discountPercentage)
        self.name.text = product.title
        self.stock.text = product.stock?.formatted()
        
        let processor = DownsamplingImageProcessor(size: thumb.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        thumb.kf.indicatorType = .activity
        thumb.kf.setImage(
            with: product.thumb,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { result in }
        
        
    }
    
    private func configurePrice(price: Double, discount: Double?) {
        
        let priceString = String(format: "%.2f", price) + " $"

        if let discount = discount, discount > 0 {
            let finalPrice = price - (price * discount/100)
            let finalPriceString = String(format: "%.2f", finalPrice) + " $"
            
            let attributeString = NSMutableAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.foregroundColor: UIColor.red])
            
            attributeString.append(NSAttributedString(string: " "))
            
            attributeString.append(NSAttributedString(string: finalPriceString, attributes: 
                [NSAttributedString.Key.foregroundColor: UIColor.green]))
            
            self.price.attributedText = attributeString
        } else {
            self.price.text = priceString
        }

    }
    
}
