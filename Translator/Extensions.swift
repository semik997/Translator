//
//  Extensions.swift
//  Translator
//
//  Created by Sem Koliesnikov on 06/02/2025.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexSanitized.hasPrefix("#")) {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgbValue >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
