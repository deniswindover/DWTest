//
//  DWTest+UIView.swift
//  DWTest
//
//  Created by Denis Windover on 16/02/2024.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable public var _cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable public var _borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable public var _borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
}
