//
//  Color.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-13.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hex.hasPrefix("#")) {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[index...])
            self.init(hexString: hexColor, alpha: alpha)
        } else {
            self.init(hexString: hex, alpha: alpha)
        }
    }
    
    private convenience init(hexString: String, alpha: CGFloat) {
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            let blue = CGFloat(hexNumber & 0x0000FF) / 255
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
}
