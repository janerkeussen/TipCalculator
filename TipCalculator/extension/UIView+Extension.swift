//
//  UIView+Extension.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import UIKit

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let bgCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = bgCGColor
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRounderCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
}
