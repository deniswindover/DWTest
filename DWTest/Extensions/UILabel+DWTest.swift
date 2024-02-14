//
//  DWTest+UILabel.swift
//  DWTest
//
//  Created by Denis Windover on 17/02/2024.
//

import Foundation
import UIKit

extension UILabel {
    
    @IBInspectable public var _isAdjustFontToSizeWidth: Bool {
        set {
            self.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return self.adjustsFontSizeToFitWidth
        }
    }
    
}

