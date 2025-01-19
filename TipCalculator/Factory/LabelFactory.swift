//
//  LabelFactory.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//
import UIKit

struct LabelFactory {
    static func build(text: String?,
                      font: UIFont,
                      backgroundColor: UIColor = .clear,
                      textColor: UIColor = ThemeColor.text,
                      textAlignment: NSTextAlignment = .center) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.backgroundColor = backgroundColor
        return label
    }
}
