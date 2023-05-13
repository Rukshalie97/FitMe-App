//
//  View.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-14.
//

import Foundation

import UIKit

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, direction: GradientDirection = .leftToRight) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        gradientLayer.frame = bounds
        
        layer.sublayers?.forEach { if type(of: $0) == CAGradientLayer.self { $0.removeFromSuperlayer() }}
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    enum GradientDirection {
        case leftToRight
        case topToBottom
        case topLeftToBottomRight
        case topRightToBottomLeft
        
        var startPoint: CGPoint {
            switch self {
            case .leftToRight:
                return CGPoint(x: 0.0, y: 0.5)
            case .topToBottom:
                return CGPoint(x: 0.5, y: 0.0)
            case .topLeftToBottomRight:
                return CGPoint(x: 0.0, y: 0.0)
            case .topRightToBottomLeft:
                return CGPoint(x: 1.0, y: 0.0)
            }
        }
        
        var endPoint: CGPoint {
            switch self {
            case .leftToRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .topToBottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topLeftToBottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            case .topRightToBottomLeft:
                return CGPoint(x: 0.0, y: 1.0)
            }
        }
    }
}
