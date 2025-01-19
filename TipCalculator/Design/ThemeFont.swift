//
//  ThemeFont.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import UIKit

struct ThemeFont {
    // AvenirNext
    static func regular(of size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func demiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
