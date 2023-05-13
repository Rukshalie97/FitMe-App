//
//  FontManager.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-13.
//

import Foundation
import UIKit

enum CustomFont: String {
    case blackItalic = "Poppins-BlackItalic"
    case bold = "Poppins-Bold"
    case extraLight = "Poppins-ExtraLight"
    case italic = "Poppins-Italic"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case remiBold = "Poppins-SemiBold"
}

final class FontManager {
    static let shared = FontManager()

    private init() {}

    func customFont(_ font: CustomFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
            fatalError("Failed to load the \(font.rawValue) font.")
        }
        return customFont
    }
}
